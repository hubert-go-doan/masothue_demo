class ApplicationController < ActionController::Base
  include Pagy::Backend

  protected

  def after_sign_in_path_for(resource)
    admin_root_path 
  end
end
