Rails.application.routes.draw do
  resources :results
  resources :subjects
  resources :notifications
  resources :documents, except: [:show]
  get 'home/index'
  resources :departments
  resources :regulations
  resources :batches

  devise_for :users, :skip => [:registrations]

  resources :users, except: [:show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
