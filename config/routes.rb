Rails.application.routes.draw do
  root to: 'projects#index'

  resources :projects do
    resources :tasks
    resources :assignments, only: [:update]
    resources :members
  end
  
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: [:show, :update]
  match 'users', to: 'users#index', constraints: { format: 'json' }, via: :get
  resource :user, only: [:edit]

end
