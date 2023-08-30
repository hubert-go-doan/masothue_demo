class PasswordsController < Devise::PasswordsController
  layout 'login_layout', only: %i[new edit]
end
