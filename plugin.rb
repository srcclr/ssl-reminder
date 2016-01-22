# name: SSL Reminder
# about: SSL Reminder tool reminds of the upcoming expiry of SSL certificates
# version: 0.0.1

require(File.expand_path("../lib/ssl_reminder", __FILE__))

register_asset("stylesheets/ssl_reminder/ssl-reminder.css.scss")
register_asset("stylesheets/ssl_reminder/bar-chart.css.scss")

after_initialize do
  require(File.expand_path("../app/models/user", __FILE__))
end

Discourse::Application.routes.append do
  mount SslReminder::Engine, at: "/ssl-reminder"
end
