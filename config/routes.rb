Rails.application.routes.draw do
  resources :docs, shallow:true do
    collection do
      get :recent
      get :active
      get :zeroviews
    end
    resources :doc_comments do
      resources :doc_replies
    end
  end

  resources :users do
    member do
      get :following, :followers
    end 
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy, :edit,:update]
  resources :relationships, only: [:create, :destroy]
  resources :favorite_docs, only: [:index, :create, :destroy]
  root to: 'static_pages#home'
  match '/help',    to: 'static_pages#help' , via: 'get'
  match '/about',   to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/signup',  to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: :delete
end