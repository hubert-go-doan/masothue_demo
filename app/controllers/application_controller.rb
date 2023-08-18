class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_in_path_for
    admin_tax_codes_path
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
