Rails.application.routes.draw do
    root 'pages#home'
    get 'about', to: 'pages#about'
    resources :reviews, only: [:show, :index, :new, :create, :destroy] 
    
    get 'signup', to: 'users#new'
    resources :users, except: [:new]
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'trail_search', to: 'trails#searchpage'
    get 'find_trails', to: 'trails#lookup'
    post 'find_trails', to: 'trails#create'
    resources :trails, only: [:show, :index, :destroy]
end
