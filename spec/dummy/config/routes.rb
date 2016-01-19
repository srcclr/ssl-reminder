Rails.application.routes.draw do
  mount SslReminder::Engine => "/ssl_reminder"
end
