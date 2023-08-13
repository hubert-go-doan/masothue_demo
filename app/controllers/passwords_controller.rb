class PasswordsController < Devise::PasswordsController
  layout 'login_layout', only: [:new] 
end
