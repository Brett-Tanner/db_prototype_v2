# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(/:locale)', locale: /ja|en/ do
    devise_for :users, path: 'auth', controllers: {
      registrations: 'users/registrations'
    }

    # Require users to be signed in to view these resources
    authenticate :user do
      resources :adjustments
      resources :areas
      resources :children
      resources :coupons
      resources :events
      resources :options
      resources :registrations
      resources :schools
      resources :time_slots
      resources :users

      # Ensures just the locale also goes to root
      get '/:locale', to: 'users#profile'
    end
    get '/current_event', to: 'welcomes#current_event'
    get 'errors/child_theft', to: 'errors#child_theft', as: :child_theft
    get '/errors/permission', to: 'errors#permission', as: :no_permission
    get 'errors/required_user', to: 'errors#required_user', as: :required_user
    get 'user/add_child', to: 'users#add_child', as: :add_child
  end

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'users#profile', as: :authenticated_root
  end
  root to: redirect('/auth/sign_in')
end
