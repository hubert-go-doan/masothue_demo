class Admin::BaseController < ApplicationController
  layout 'admin_layout'
  before_action :authenticate_user!

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index; end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def authenticate_user!
    redirect_to new_user_session_path unless current_user
  end
end
