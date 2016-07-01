require 'api_constraints'

MyApi::Application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show]
    end
  end
end
