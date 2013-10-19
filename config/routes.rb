Dashub::Application.routes.draw do
  root to: 'projects#index'

  resources :projects, except: :destroy do
    resources :repositories, except: :destroy
  end
end
