Rails.application.routes.draw do
  get 'settings/index'
  post 'settings/update'

  devise_for :users
  resources :categories

  resources :tasks do
    collection do
      patch 'finish'
    end
  end

  root 'tasks#index'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
