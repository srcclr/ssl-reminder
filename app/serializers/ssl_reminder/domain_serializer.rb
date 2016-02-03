module SslReminder
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url, :expiration_date, :scanned, :status, :notification_enabled
  end
end
