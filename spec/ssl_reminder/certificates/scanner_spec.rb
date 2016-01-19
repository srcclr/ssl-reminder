require "rails_helper"

describe SslReminder::Certificates::Scanner do
  let(:scanner) { described_class.new(url) }
  let(:url) { "github.com" }

  let(:connection) { double(:connection, result_url: "https://github.com") }
  let(:http_client) { double(:http_client, start: certificate).as_null_object }
  let(:certificate) { double(:certificate, not_after: "2016-04-12 12:00:01 UTC") }

  before do
    allow(SslReminder::Certificates::Connection).to receive(:new).and_return(connection)
    allow(Net::HTTP).to receive(:new).and_return(http_client)
  end

  subject { scanner.scan! }

  it "returns ssl certificate expiry date" do
    expect(subject).to eq("2016-04-12 12:00:01 UTC")
  end
end
