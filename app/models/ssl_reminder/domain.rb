module SslReminder
  class Domain < ActiveRecord::Base
    belongs_to :user

    def days_remaining
      return if expiration_date.blank?

      [(expiration_date - Date.current).to_i, 0].max
    end

    def status
      if (1..7).include?(days_remaining)
        "danger"
      elsif (8..30).include?(days_remaining)
        "warning"
      else
        ""
      end
    end
  end
end
