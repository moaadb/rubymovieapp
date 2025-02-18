Rails.application.routes.draw do
  root 'home#index'

  resources :users do
    resources :tickets, only: [:index] do
      member do
        post :cancel
      end
    end

    resources :credit_cards, only: [:index, :new, :create, :destroy]
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :movies do
    resources :shows do
      resources :tickets, only: [:new, :create]
    end
  end

  resources :tickets, only: [:new, :create, :edit, :update, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
