# frozen_string_literal: true

Rails.application.routes.draw do
  get '/ping', to: 'ping#index'
  post '/register', to: 'register#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
