module SslReminder
  module Certificates
    class Connection
      def initialize(url)
        @url = url
      end

      def result_url
        response.env.url.to_s
      end

      def response
        @response ||= client.get
      end

      private

      def client
        Faraday.new(url: "http://#{@url}", headers: header_options, request: request_options) do |builder|
          builder.request :url_encoded
          builder.use FaradayMiddleware::FollowRedirects, limit: 10
          builder.adapter Faraday.default_adapter
        end
      end

      def header_options
        @header_options ||=
          {
            accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            accept_encoding: "none",
            accept_language: "en-US,en;q=0.5",
            user_agent: "Mozilla/5.0 AppleWebKit/537.36 Chrome/46.0.2490.71 Safari/537.36 Firefox/41.0"
          }
      end

      def request_options
        @request_options ||=
          {
            timeout: 15,
            open_timeout: 5
          }
      end
    end
  end
end
