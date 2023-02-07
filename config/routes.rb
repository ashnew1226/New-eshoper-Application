Rails.application.routes.draw do
  
  resources :categories, only: [:index, :show]
  resources :contacts
  resources :profile, only: [:edit, :update]
  resources :user_addresses
  get 'coupons/new'
  post 'coupons/apply_coupon'
  get 'checkout/index'
  get 'cart/index'
  post "cart/create/:id", to: "cart#create", as: "cart_create"
  delete 'cart/destroy/:id',to: 'cart#destroy', as: "cart_destroy"
  get 'wishlist/index'
  get 'wishlist/create/:id', to: "wishlist#create", as:"wishlist_create"
  delete 'wishlist/destroy/:id',to: 'wishlist#destroy', as: "wishlist_destroy"
  get 'product/index'
  get 'product/show/:id', to: "product#show", as: 'product_show'
  post "cart/increase_quantity/:id", to: "cart#increase_quantity", as: "increase_quantity"
  post "cart/decrease_quantity/:id", to: "cart#decrease_quantity", as: "decrease_quantity"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  post '/add_subscription_mailchimp', to: "home#add_subscription_mailchimp", as:"mailchimp_users"
  get 'orders/index', to: 'orders#index'
  post 'orders/submit', to: 'orders#submit'
  get 'orders/submit', to: 'orders#submit', as: 'submit_order'

  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "profile/myorder"
  get "profile/track_order"
  get 'eshop/index', to: 'eshop#index'
  post 'eshop/cart', to: 'eshop#cart'
  get 'eshop/login'
  # get 'eshop/blog_single'
  get 'eshop/blog'
  get 'eshop/cart'
  # post 'eshop/apply_coupon', to: 'eshop#apply_coupon', as: 'apply_coupon'
  # patch 'eshop/cart', to: 'eshop#cart', as: 'coupons'
  get 'eshop/checkout'
  get 'eshop/contact'
  post 'eshop/contact_us'
  get 'eshop/error404'
  get 'eshop/payment_success'
  get 'eshop/wishlist'
  # post 'eshop/add_user_address', to: 'eshop#add_user_address', as: 'user_address'
  get 'eshop/product_details/:id', to: 'eshop#product_details', as: 'product_details'
  get 'eshop/cat_prods/:id', to: 'eshop#cat_prods', as: 'cat_prods'
  get 'eshop/shop'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "eshop/add_to_cart/:id", to: "eshop#add_to_cart", as: "add_to_cart"
  delete "eshop/remove_from_cart/:id", to: "eshop#remove_from_cart", as: "remove_from_cart"
  delete "eshop/remove_from_cart1/:id", to: "eshop#remove_from_cart1", as: "remove_from_cart1"
  # Defines the root path route ("/")
  # root "articles#index"
  # Increasing decreasing quantity of product
  # post "eshop/increase_quantity/:id", to: "eshop#increase_quantity", as: "increase_quantity"
  # post "eshop/decrease_quantity/:id", to: "eshop#decrease_quantity", as: "decrease_quantity"

  # checkout routes
  # get "eshop/user_order_information", to: "eshop#user_order_information"
  post "eshop/user_order_information", to: "eshop#user_order_information"
  
  # resources :billings

  get 'eshop/cash_on_delivery', to: 'eshop#cash_on_delivery', as: 'cash_on_delivery'
  get 'eshop/success', to: 'eshop#success', as: 'order_success'

  get 'eshop/add_to_wishlist/:id', to: 'eshop#add_to_wishlist'
  delete 'eshop/remove_from_wishlist/:id', to: 'eshop#remove_from_wishlist', as: 'remove_from_wishlist'

  resources :blogs
end

