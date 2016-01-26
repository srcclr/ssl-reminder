module Jobs
  module SslReminder
    class ScanCertificates < Jobs::Scheduled
      every 1.day

      DEFAULT_BATCH_SIZE = 100
      DAILY_THRESHOLD_DAYS = 7
      WEEKLY_THRESHOLD_DAYS = 31
      WEEKLY_DAY_TO_SEND = 1

      def execute(_args)
        ::SslReminder::Domain.find_in_batches(batch_size: DEFAULT_BATCH_SIZE) do |domains|
          domains.each { |domain| process_domain(domain) }
        end
      end

      private

      def process_domain(domain)
        update_certificate_info(domain)
        send_report(domain) if valid_to_send?(domain)
      end

      def update_certificate_info(domain)
        scanner = ::SslReminder::Certificates::Scanner.new(domain.url)
        new_expiration_date = scanner.scan
        return if new_expiration_date.blank?

        domain.expiration_date = new_expiration_date
        domain.save! if domain.changed?
      end

      def send_report(domain)
        report = ::SslReminderReportMailer.report(domain)
        Email::Sender.new(report, :ssl_reminder).send
      end

      def valid_to_send?(domain)
        return false unless domain.notification_enabled? && domain.days_remaining.present?

        domain.days_remaining <= DAILY_THRESHOLD_DAYS ||
          domain.days_remaining <= WEEKLY_THRESHOLD_DAYS && Date.current.wday == WEEKLY_DAY_TO_SEND
      end
    end
  end
end
