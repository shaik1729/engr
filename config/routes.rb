Rails.application.routes.draw do
  resources :results
  resources :subjects, except: [:show]
  resources :notifications, only: [:index, :new, :create]
  resources :documents, except: [:show]
  get 'home/index'
  resources :departments, except: [:show]
  resources :regulations, except: [:show]
  resources :batches, except: [:show]

  devise_for :users, :skip => [:registrations]

  resources :users, except: [:show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
