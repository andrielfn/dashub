Dashub::Application.routes.draw do
  get "welcome/index"
  root to: 'welcome#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :projects, except: :destroy do
    resources :repositories, only: [:new, :create, :destroy]
  end
end
