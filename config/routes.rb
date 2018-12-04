Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get 'about', to: 'pages#about'


  get 'signup', to: 'users#new'
  resources :users, except: [:new]


  #paths for CRUD on articles
  resources :articles
end
