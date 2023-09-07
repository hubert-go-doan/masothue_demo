class ApplicationController < ActionController::Base
  include Pagy::Backend

  protected

  def after_sign_in_path_for(_resource)
    admin_tax_codes_path
  end
end
