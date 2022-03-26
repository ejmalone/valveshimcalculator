Rails.application.routes.draw do
  resources :shims
  resources :engines
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root "application#index"

  resources :users
  resources :engines do
    resources :shims
  end
end
