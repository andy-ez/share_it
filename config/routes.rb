PostitTemplate::Application.routes.draw do

  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    member do
      post :vote, to: 'posts#vote'
    end
    resources :comments, only: [:create] do
      member do
        post :vote, to: 'comments#vote'
      end
    end
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, except: [:new]
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  post 'login', to: 'sessions#create'

end
