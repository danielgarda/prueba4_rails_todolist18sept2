Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    post 'show/:task_id', to: 'tasks#show', as: 'show'
    post 'add_user/:task_id', to: 'tasks#add_user', as: 'add_user'
    delete 'remove_user/:task_id', to: 'tasks#remove_user', as: 'remove_user'
  end
  
  root to: 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



