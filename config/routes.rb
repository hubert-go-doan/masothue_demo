Rails.application.routes.draw do
  # route devise
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    passwords: 'passwords'
  }

  # Route admin
  namespace :admin do
    root to: 'base#index'
    resources :companies
    resource :city
    resources :contacts, only: [:index, :show, :edit, :update, :destroy]
  end

  # route homepage
  root 'main#home'
  get '/contacts', to: 'contacts#new'
  post '/contacts', to: 'contacts#create'
end
