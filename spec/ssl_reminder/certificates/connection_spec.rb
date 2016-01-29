require "rails_helper"

describe SslReminder::Certificates::Connection do
  let(:connection) { described_class.new(url) }
  let(:url) { "scanned.url" }
  let(:client) { double(:client, get: response) }
  let(:response) { double(:response, env: double(:env, url: "https://scanned.url/")) }

  before do
    allow(Faraday).to receive(:new).and_return(client)
  end

  subject { connection.result_url }

  it "returns last redirected response" do
    expect(subject).to eq("https://scanned.url/")
  end
end
