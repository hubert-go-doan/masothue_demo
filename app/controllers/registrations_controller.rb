class RegistrationsController < Devise::RegistrationsController
  layout 'login_layout', only: [:edit]
end
