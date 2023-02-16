Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  resources :categories, only: [:index, :show]
  resources :contacts
  resources :profile, only: [:edit, :update]  
  #   collection do
  #     get "profile/track_order"
  #     get "profile/myorder"
  #   end 
  #   member do
  #     post "profile/order_tracking"
  #   end
  # end
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
    member do
      post 'submit'
    end
  end
  resources :blogs
  post '/add_subscription_mailchimp', to: "home#add_subscription_mailchimp", as:"mailchimp_users"
  root 'home#index'
  get "profile/myorder"
  get "profile/track_order"
  post "profile/track_order"
end

