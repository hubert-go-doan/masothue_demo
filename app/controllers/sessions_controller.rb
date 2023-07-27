class SessionsController < Devise::SessionsController
  layout 'login_layout', only: [:new]
end
