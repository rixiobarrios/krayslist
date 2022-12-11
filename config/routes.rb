Rails.application.routes.draw do
  root 'locations#index'

  devise_for :users
  # creating user views
  # resources :users, only: [:index, :show, :new, :edit, :update, :delete]
  resources :users
  resources :messages
  resources :locations
  resources :categories
  resources :listings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
