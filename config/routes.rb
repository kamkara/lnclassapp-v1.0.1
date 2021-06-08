Rails.application.routes.draw do
  get 'admin/index'
  get 'tablesclass/index'
  get 'accounted/teachers'
  get 'accounted/teams'
  get 'profil/index'
  resources :courses do
    resources :posts
    resources :messages
  end
  resources :materials
  resources :levels
  root to:'homes#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
