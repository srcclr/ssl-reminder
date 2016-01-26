module SslReminder
  class Domain < ActiveRecord::Base
    belongs_to :user

    def days_remaining
      if expiration_date.blank?
        nil
      else
        [(expiration_date - Date.current).to_i, 0].max
      end
    end
  end
end
