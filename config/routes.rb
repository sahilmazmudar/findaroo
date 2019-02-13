Rails.application.routes.draw do
  root to: 'home#index'
  resources :users, only: [:index, :show, :update, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
