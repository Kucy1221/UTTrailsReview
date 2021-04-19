Rails.application.routes.draw do
    root 'pages#home'
    get 'about', to: 'pages#about'
    resources :reviews, only: [:show, :index, :new, :create, :destroy] 
    get 'signup', to: 'users#new'
    resources :users, except: [:new]
end
