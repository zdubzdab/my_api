require 'api_constraints'

MyApi::Application.routes.draw do

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show]
      resources :sessions, :only => [:create, :destroy]
      devise_for :users
    end
  end
end
