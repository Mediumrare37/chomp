Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :notifications, only: [:index, :update]
  resources :tasks, only: [:show, :create, :index]
  resources :chasks do
    member do
      patch :excluded
      patch :queued
      patch :progress
      patch :paused
      patch :completed
      get :breakdown
    end
  end

end
