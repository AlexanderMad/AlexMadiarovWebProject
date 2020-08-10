Rails.application.routes.draw do
  get 'welcome/index'

  resources :products do
    # resources :comments

    member do
      get :add_to_cart, to: 'products#add_to_cart'
    end
  end

  # get 'products/cart' #, to: 'products#view_cart'
  # match "cart" => "products#cart"

  match 'cart' => 'products#cart', :via => [:get], :as => 'cart'
  match 'checkout' => 'products#checkout', :via => [:get], :as => 'checkout'


  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
