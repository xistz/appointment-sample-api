# frozen_string_literal: true

Rails.application.routes.draw do
  resources :appointments, only: %i[index create destroy]
  resources :availabilities, only: %i[index create destroy]
  get '/ping', to: 'ping#index'
  post '/register', to: 'register#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
