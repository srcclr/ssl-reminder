module SslReminder
  class DomainsController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in

    respond_to :html, :json

    def index
      respond_to do |format|
        format.json { render json: {} }
        format.html { render "default/empty" }
      end
    end
  end
end
