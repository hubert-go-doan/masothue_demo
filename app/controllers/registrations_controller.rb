class RegistrationsController < Devise::RegistrationsController
  layout 'login_layout', only: [:new]
end