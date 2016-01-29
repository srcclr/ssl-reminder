module SslReminder
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url, :expiration_date, :status, :notification_enabled
  end
end
