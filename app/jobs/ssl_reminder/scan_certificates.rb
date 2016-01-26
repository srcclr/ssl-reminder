module Jobs
  module SslReminder
    class ScanCertificates < Jobs::Scheduled
      every 1.day

      DEFAULT_BATCH_SIZE = 100

      def execute(_args)
        ::SslReminder::Domain.find_in_batches(batch_size: DEFAULT_BATCH_SIZE) do |domains|
          domains.each { |domain| process_domain(domain) }
        end
      end

      private

      def process_domain(domain)
        notifier = ::SslReminder::Certificates::Notifier.new(domain)
        notifier.call
      end
    end
  end
end
