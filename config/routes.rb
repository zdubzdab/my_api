require 'api_constraints'

MyApi::Application.routes.draw do
  resources :comments
  resources :articles
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :index]
      #user controller
      put "/users/update" => "users#update"
      delete "/users/destroy" => "users#destroy"
      #session controller
      devise_for :users, skip: [:registrations, :sessions, :passwords]
      devise_scope :user do
        post "/users/sign_in" => "sessions#create"
        delete "/users/sign_out" => "sessions#destroy"
      end
      namespace :admin do
        resources :users, only: [:update, :destroy]
      end
      resources :articles do
        resources :comments, only: [:create, :update, :destroy, :show]
      end
    end
  end
end
