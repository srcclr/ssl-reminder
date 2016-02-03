module SslReminder
  class DomainsController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in

    respond_to :html, :json

    rescue_from Discourse::NotLoggedIn do
      if (request.format && request.format.json?) || request.xhr? || !request.get?
        render json: {}
      else
        redirect_to path("/projects/ssl-reminder")
      end
    end

    def index
      respond_to do |format|
        format.json { render json: user_domains }
        format.html do
          store_preloaded("domains", MultiJson.dump(user_domains))
          render "default/empty"
        end
      end
    end

    def create
      domain = Domain.create!(domain_params.merge(user_id: current_user.id))
      render json: domain
    end

    def destroy
      status = domain && domain.destroy ? :ok : :not_found

      head status
    end

    def scan
      domain.update(expiration_date: scanner.scan)
      render json: domain
    end

    def toggle_notification
      status = domain.update(notification_enabled: !domain.notification_enabled) ? :ok : :not_found

      head status
    end

    private

    def user_domains
      serialize_data(
        current_user,
        UserWithDomainsSerializer,
        root: false,
        host: request.base_url
      )
    end

    def domain
      @domain ||= current_user.ssl_reminder_domains.find_by_id(params[:id])
    end

    def domain_params
      params.require(:domain).permit(:name, :url)
    end

    def scanner
      SslReminder::Certificates::Scanner.new(domain.url)
    end
  end
end
