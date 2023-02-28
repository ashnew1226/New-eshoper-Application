Rails.application.routes.draw do
  root 'home#index'
  resources :home do
    collection do 
      post 'add_subscription_mailchimp'
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  resources :categories, only: [:index, :show]
  resources :contacts
  resources :profile, only: [:edit, :update] do
    collection do
      get "track_order"
      post "track_order"
      get "myorder"
    end 
  end
  resources :addresses
  resources :coupons, only: [:new] do
    collection do
      post 'apply_coupon'
    end
  end
  resources :checkout, only: [:index]
  resources :carts, only: [:index, :create, :destroy] do 
    member do
      post 'increase_quantity', to: "carts#increase_quantity", as: "increase_quantity"
      post 'decrease_quantity', to: "carts#decrease_quantity", as: "decrease_quantity"
    end
  end
  resources :wishlists, only: [:index, :create, :destroy]
  resources :products, only: [:index, :show] 
  resources :orders, only: [:index] do
    collection do
      post 'submit'
    end
  end
  resources :blogs

end

