# name: SSL Reminder
# about: SSL Reminder tool reminds of the upcoming expiry of SSL certificates
# version: 0.0.1

require(File.expand_path("../lib/ssl_reminder", __FILE__))

Discourse::Application.routes.append do
  mount SslReminder::Engine, at: "/ssl-reminder"
end
