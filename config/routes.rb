Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :passwords]

  root to: 'home#index'

  resources :posts do
    collection do
      get :search
      post :preview
      get :published
      get :draft
      get :template
    end
    resources :versions, only: [:index, :show] do
      get :current, on: :collection
    end
    resources :comments, only: [:create] do
    end
  end
  resources :comments, only: [:index]
  resources :attachments, only: [:index, :new, :create, :destroy]
  resources :links, only: [:create]

  resource :identity, only: [:new, :destroy]
  get '/auth/:provider/callback', to: 'identities#create'
end
