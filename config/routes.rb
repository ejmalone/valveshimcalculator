Rails.application.routes.draw do
  resources :engines do
    resources :cylinders do
      resources :valves
    end
  end

  resources :users
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root "application#index"
end
