Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users,
  only: :registrations,
  controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do

    namespace :v1, defaults: { format: :json } do
      get 'users/sync', to: 'users#sync'

      resources :projects, only: [:create, :show]

      root 'user_projects#index'
    end

  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

end
