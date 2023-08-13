Rails.application.routes.draw do
  # route error
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

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
    
    resources :companies do
      collection do 
        get 'search', to: 'companies#search', as: :search_company
      end
    end

    resources :people do 
      collection do
        get 'search', to: 'people#search', as: :search_person
      end
    end

    resources :company_types, only: [:index]
    resources :represents
    resources :contacts, only: [:index, :show, :edit, :update, :destroy]

    resources :tax_codes do
      collection do
        get :company_options
        get :person_options
        get 'search', to: 'tax_codes#search', as: :search_tax_code
      end
    end

    resources :business_areas do
      collection do
        get 'search', to: 'business_areas#search', as: :search_business_are 
      end
    end
  end

  # route homepage
  root 'main#home'
  resources :company_types  
  resources :business_areas
  resources :newly_established
  resources :status
  resources :cities
  resources :tax_code_personal do
    collection do
      get 'search', to: 'tax_code_personal#search', as: :search_person
    end
  end
  get 'info_detail/:id/:type', to: 'main#info_detail', as: :info_detail
  get 'cities/district/:id', to: 'cities#show_district', as: 'district'
  get 'cities/ward/:id', to: 'cities#show_ward', as: 'ward'
  get '/contacts', to: 'contacts#new'
  post '/contacts', to: 'contacts#create'
  get 'search', to: 'main#search', as: :search
end
