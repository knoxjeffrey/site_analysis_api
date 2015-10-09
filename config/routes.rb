Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users,
  only: :registrations,
  controllers: {
    registrations: 'users/registrations'
  }

  namespace :api, defaults: { format: :json }, path: '/' do

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      get 'users/sync', to: 'users#sync'

      resources :projects, only: [:create, :show]

      root 'user_projects#index'
    end

  end

end
