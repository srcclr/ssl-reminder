module SslReminder
  class Domain < ActiveRecord::Base
    belongs_to :user
  end
end
