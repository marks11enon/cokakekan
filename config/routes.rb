Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/main_page' => "homes#main_page", as: "main_page"
  devise_for :users
  get 'users/my_page' => "users#show", as: "my_page"
  resources :users, only: [:edit, :update]
  resources :categories, only: [:index, :create, :edit, :destroy, :update]
  resources :budgets, only: [:new, :create, :destroy, :index]
  resources :months, only: [:new, :create, :index, :show, :edit, :update, :destroy], shallow: true do
    resources :details, only: [:new, :create, :index, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
