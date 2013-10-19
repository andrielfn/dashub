Dashub::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: 'projects#index'

  resources :projects, except: :destroy do
    resources :repositories, except: :destroy
  end
end
