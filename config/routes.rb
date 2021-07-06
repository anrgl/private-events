Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :users, only: %i[ show ]
  resources :events do
    member do
      get 'rsvp'
      get 'cancel_rsvp'
    end
  end
end
