Dashub::Application.routes.draw do
  get 'welcome/index'
  root to: 'projects#index'

  resources :projects do
    resources :repositories
  end
end
