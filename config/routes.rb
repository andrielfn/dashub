Dashub::Application.routes.draw do
  devise_for :users
  get 'welcome/index'
  root to: 'projects#index'

  resources :projects, except: :destroy do
    resources :repositories, except: :destroy
  end
end
