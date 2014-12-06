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
  end
  resources :attachments, only: [:index, :new, :create, :destroy]
  resources :links, only: [:create]
end
