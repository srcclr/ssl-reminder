module SslReminder
  class NotifiableDomainPolicy
    DAILY_THRESHOLD_DAYS = 7
    WEEKLY_THRESHOLD_DAYS = 31
    WEEKLY_DAY_TO_SEND = 1

    attr_reader :domain
    private :domain

    def initialize(domain)
      @domain = domain
    end

    def valid?
      return false unless domain.notification_enabled? && domain.days_remaining.present?

      (1..DAILY_THRESHOLD_DAYS).cover?(domain.days_remaining) ||
        domain.days_remaining <= WEEKLY_THRESHOLD_DAYS && Date.current.wday == WEEKLY_DAY_TO_SEND
    end
  end
end
