module SslReminder
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url, :expiry_date, :status, :notification_enabled
  end
end
