Dashub::Application.routes.draw do
  get 'welcome/index'
  root to: 'projects#index'

  resources :projects, except: :destroy do
    resources :repositories, except: :destroy
  end
end
