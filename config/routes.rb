Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # get 'boards', to: 'boards#index'
  # get 'boards/new', to: 'boards#new'
  # get 'boards/:id', to: 'boards#show' 
  # post 'boards', to: 'boards#create'
  resources :boards, only: [:index, :new, :create, :show, :edit, :update]
end
