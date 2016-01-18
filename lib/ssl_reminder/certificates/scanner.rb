module SslReminder
  module Certificates
    class Scanner
      def initialize(url)
        @url = url
      end

      def scan!
        cert = fetch_certificate
        save_cert(cert)
      end

      private

      def fetch_certificate
        uri = URI.parse(connection.result_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.start { |h| h.peer_cert }
      end

      def connection
        @connection ||= Connection.new(@url)
      end
    end
  end
end
