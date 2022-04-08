Rails.application.routes.draw do
  devise_for :users
  resources :user

  resources :engines do
    resources :cylinders do
      resources :valves
    end

    resources :shims, only: [ :new, :create ] do
      collection do
        get "edit_all"
        put "update_all"
        put "create_all"
      end
    end

    resources :valve_adjustments do
      member do
        get "adjust"
        put "update_shims"
        put "complete"
      end
    end
  end

  get '/enable_debug', to: 'application#enable_debug'
  get '/disable_debug', to: 'application#disable_debug'
  root "application#index"
end
