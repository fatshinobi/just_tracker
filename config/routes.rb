Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :categories

  resources :tasks do
    collection do
      patch 'finish'
    end
    member do
      patch 'continue'
    end
  end

  root 'tasks#index'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
