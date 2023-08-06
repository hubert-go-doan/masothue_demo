class RegistrationsController < Devise::RegistrationsController
  layout 'login_layout', only: [:new]
  protected

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_inactive_sign_up_path_for resource
    new_user_registration_path
  end
end
