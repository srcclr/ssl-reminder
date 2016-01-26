module SslReminder
  module Certificates
    class Notifier
      attr_reader :domain
      private :domain

      def initialize(domain)
        @domain = domain
      end

      def call
        update_certificate_info
        send_report if policy.valid?
      end

      private

      def update_certificate_info
        new_expiration_date = scanner.scan
        return if new_expiration_date.blank?

        domain.expiration_date = new_expiration_date
        domain.save! if domain.changed?
      end

      def send_report
        report = SslReminderReportMailer.report(domain)
        Email::Sender.new(report, :ssl_reminder).send
      end

      def scanner
        SslReminder::Certificates::Scanner.new(domain.url)
      end

      def policy
        SslReminder::NotifiableDomainPolicy.new(domain)
      end
    end
  end
end
