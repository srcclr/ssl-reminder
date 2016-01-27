require "rails_helper"

describe SslReminder::NotifiableDomainPolicy do
  describe "#valid?" do
    let(:policy) { described_class.new(domain) }
    let(:domain) { create(:domain, url: "github.com", expiration_date: expiration_date, notification_enabled: true) }

    subject { policy }

    context "when expiration_date is empty" do
      let(:expiration_date) { nil }

      it { is_expected.not_to be_valid }
    end

    context "when expiration_date is in past" do
      let(:expiration_date) { Date.current.yesterday }

      it { is_expected.not_to be_valid }
    end

    context "when expiration_date is within a week" do
      let(:expiration_date) { Date.current.tomorrow }

      it { is_expected.to be_valid }
    end

    context "when expiration_date is within a month" do
      let(:expiration_date) { 2.weeks.from_now }

      context "when weekday is Monday" do
        before { allow_any_instance_of(Date).to receive(:wday).and_return(1) }

        it { is_expected.to be_valid }
      end

      context "when weekday is not Monday" do
        before { allow_any_instance_of(Date).to receive(:wday).and_return(5) }

        it { is_expected.not_to be_valid }
      end
    end
  end
end
