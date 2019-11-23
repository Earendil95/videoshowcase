# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contents, only: :index
  resources :movies, only: :index
  resources :purchasings, only: %i[index create]
  resources :seasons, only: :index
end
