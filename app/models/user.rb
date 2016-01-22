User.class_eval do
  has_many :ssl_reminder_domains, -> { order(:name) }, class_name: "SslReminder::Domain"
end
