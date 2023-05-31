Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  #added the send notifications
  # post '/send_notification', to: 'notifications#send_notification'

  # Defines the root path route ("/")
  # root "articles#index"
  resources :notifications, only: [:index, :update]
  resources :tasks, only: [:show, :create, :index]
  resources :chasks do
    resources :messages, only: [:create]
    member do
      patch :excluded
      patch :queued
      patch :progress
      patch :paused
      patch :completed
      get :breakdown
      patch :deadline
      patch :global_deadline
      # get :show
      # get :new
      # post :create
      # delete :destroy
    end
  end

end
