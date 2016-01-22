module SslReminder
  class UserWithDomainsSerializer < ActiveModel::Serializer
    has_many :ssl_reminder_domains, serializer: DomainSerializer, embed: :objects
  end
end
