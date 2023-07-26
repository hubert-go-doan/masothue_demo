Rails.application.routes.draw do
  # get 'contacts/index'
  get 'contacts', to: 'contacts#index'
  devise_for :users
  root 'main#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
