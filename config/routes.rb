Dashub::Application.routes.draw do
  get "welcome/index"
  root to: 'welcome#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :projects, except: :destroy do
    resources :repositories, only: [:new, :create]
  end
end
