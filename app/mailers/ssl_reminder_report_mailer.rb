require_dependency "email/message_builder"

class SslReminderReportMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def report(domain)
    email_opts = {
      template: "ssl_reminder",
      html_override: html(domain)
    }

    build_email(domain.user.email, email_opts)
  end

  private

  def html(domain)
    ActionView::Base.new("plugins/ssl-reminder/app/views").render(
      template: "email/ssl_reminder",
      format: :html,
      locals: {
        domain_name: domain.name,
        domain_url: domain.url,
        days_remaining: domain.days_remaining,
        ssl_status: domain.status
      }
    )
  end
end
