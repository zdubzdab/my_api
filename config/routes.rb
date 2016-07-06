require 'api_constraints'

MyApi::Application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :index]
      #user controller
      put "/users/update" => "users#update"
      delete "/users/destroy" => "users#destroy"
      #session controller
      post "/users/sign_in" => "sessions#create"
      delete "/users/sign_out" => "sessions#destroy"
    end
  end
end
