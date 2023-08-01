Rails.application.routes.draw do
  # route devise
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    passwords: 'passwords'
  }

  # route admin
  namespace :admin do
    root to: 'base#index'
    
    get 'districts_by_city', to: 'districts#districts_by_city'
    get 'wards_by_district', to: 'wards#wards_by_district'
    
    resources :companies
    resources :people
    resources :contacts, only: [:index, :show, :edit, :update, :destroy]
    resources :tax_codes do
      collection do
        get :company_options
        get :person_options
      end
    end
  end

  # route homepage
  root 'main#home'
  get '/contacts', to: 'contacts#new'
  post '/contacts', to: 'contacts#create'
  get '/homepage', to: 'admin/companies#homepage'
end
