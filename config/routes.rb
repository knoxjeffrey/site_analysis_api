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

      resources :projects, only: [:create, :show] do
        member do
          resources :page_speed_results, only: [:index, :show]
          post '/run_page_speed_test', to: 'page_speed_results#create'
        end
      end

      root 'user_projects#index'
    end

  end

end
