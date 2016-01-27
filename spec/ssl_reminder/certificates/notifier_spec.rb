require "rails_helper"

describe SslReminder::Certificates::Notifier do
  let(:notifier) { described_class.new(domain) }
  let(:domain) { create(:domain, url: "github.com") }
  let(:expiration_date) { Date.parse("2016-04-12 12:00:00 UTC") }

  before do
    allow(SslReminder::Certificates::Scanner).to receive(:scan)
      .and_return(expiration_date)
  end

  subject { notifier.call }

  it "updates domain's certificate expiration date" do
    expect { subject }.to change { domain.reload.expiration_date }.from(nil).to(expiration_date)
  end

  describe "notifications" do
    let(:email_sender) { double(:email_sender, send: true) }

    before do
      stub_const("Email::Sender", double)
      stub_const("SslReminderReportMailer", double)

      allow(Email::Sender).to receive(:new).and_return(email_sender)
      allow(SslReminderReportMailer).to receive(:report)

      allow_any_instance_of(SslReminder::NotifiableDomainPolicy).to receive(:valid?)
        .and_return(policy_valid?)

      subject
    end

    context "when domain is notifiable" do
      let(:policy_valid?) { true }

      it "sends notification" do
        expect(email_sender).to have_received(:send)
      end
    end

    context "when domain is not notifiable" do
      let(:policy_valid?) { false }

      it "sends notification" do
        expect(email_sender).not_to have_received(:send)
      end
    end
  end
end
