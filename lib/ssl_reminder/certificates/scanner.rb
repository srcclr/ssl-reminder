module SslReminder
  module Certificates
    class Scanner
      def initialize(url)
        @url = url
      end

      def scan
        cert = fetch_certificate
        cert.not_after
      rescue Net::OpenTimeout, OpenSSL::SSL::SSLError, Faraday::ConnectionFailed, Faraday::SSLError => exception
        Rails.logger.warn("Error while fetching SSL certificate for #{@url}: #{exception.inspect}")
        nil
      end

      private

      def fetch_certificate
        uri = URI.parse(connection.result_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.read_timeout = 10
        http.start(&:peer_cert)
      end

      def connection
        @connection ||= Connection.new(@url)
      end
    end
  end
end
