require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

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
        post "create_shim"
      end
    end
  end

  get '/about', to: 'application#about'
  get '/legal', to: 'application#legal'

  get '/enable_debug', to: 'application#enable_debug'
  get '/disable_debug', to: 'application#disable_debug'

  get '/users/sign_up_anonymous', to: 'anonymous_users#sign_up_anonymous', as: :sign_up_to_save
  get '/users/associate_new_user', to: 'anonymous_users#associate_new_user', as: :associate_new_user
  get '/users/restart/:token', to: 'anonymous_users#restart', as: :restart_session

  get '/uptime/check', to: 'uptime#check'
  get '/adder/:one/:two', to: "application#adder"
  root "application#index"
end
