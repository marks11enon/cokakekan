Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :categories, only: [:index, :create, :edit, :destroy, :update]
  resources :budgets
  resources :months, only: [:new, :create, :index, :show, :edit, :update, :destroy], shallow: true do
    resources :details, only: [:new, :create, :index, :edit, :update, :destroy]
  end
  get '/details/:id/edit' => "details#edit"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
