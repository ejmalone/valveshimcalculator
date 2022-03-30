Rails.application.routes.draw do
  resources :engines do
    resources :cylinders do
      resources :valves
    end

    resources :shims, only: [ :update ] do
      collection do
        get "edit_all"
        put "create_all"
      end
    end

    resources :valve_adjustments
  end

  resources :users
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root "application#index"
end
