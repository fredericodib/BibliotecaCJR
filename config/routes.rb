Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :books

  root 'books#index'

  get '/sign_up' => 'users#new', as: :sign_up
  post '/users' => 'users#create'
  patch '/users/:id' => 'users#update', as: :update_user
  get '/user_settings' => 'users#user_dates', as: :user_settings
  get '/admin_control' => 'users#admin_control', as: :admin_control
  delete '/users/:id' => 'users#destroy', as: :destroy_user
  get '/change_admin/:id' => 'users#chenge_admin', as: :chenge_admin

  get '/books/categories(/:value)/filter' => "books#filter_category"

  get '/how_works' => 'pages#how_works'
  get '/rent_book/:id' => 'orders#rent_book', as: :rent_book
  get '/return_book/:id' => 'orders#return_book', as: :return_book
  get '/confirm_return/:id' => 'orders#confirm_return', as: :confirm_return
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
