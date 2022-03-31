Rails.application.routes.draw do
  devise_for :users
  resources :user

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

  root "application#index"
end
