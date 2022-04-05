Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :categories, only: [:index, :create, :edit, :destroy, :update]
  resources :details
  resources :budgets
  resources :months, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  get '/homes/about' => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
