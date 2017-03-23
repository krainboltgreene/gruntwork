Rails.application.routes.draw do
  devise_for :accounts
  resources :orders do
    get :finish, on: :member
    get :cancel, on: :member
    get :respond, on: :member
  end

  root to: "orders#index"
end
