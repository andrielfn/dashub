Dashub::Application.routes.draw do
  devise_for :users

  root to: 'projects#index'

  resources :projects, except: :destroy do
    resources :repositories, except: :destroy
  end
end
