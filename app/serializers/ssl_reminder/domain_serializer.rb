module SslReminder
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url, :expiration_date, :created_at, :status, :notification_enabled
  end
end
