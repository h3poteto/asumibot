# frozen_string_literal: true

Rails.application.routes.draw do

  resources :patients, only: [:show, :index]
  resources :recommends, only: [:index]
  resources :movies, only: [:index] do
    collection do
      get :streaming
      get :streamnico
    end
  end
  resources :youtubes, only: :index, defaults: { format: :json } do
    collection do
      get :today
    end
  end
  resources :niconicos, only: :index, defaults: {format: :json } do
    collection do
      get :today
    end
  end

  get "/movies/show_niconico/:id" => "movies#show_niconico", :as => :niconico
  get "/movies/show_youtube/:id" => "movies#show_youtube", :as => :youtube

  devise_for :admins

  namespace :admins do
    resources :serifs, :except => [:show]
    resources :youtubemovies, :except => [:show, :destroy, :new, :create]
    resources :niconicomovies, :except => [:show, :destroy, :new, :create]
  end

  root :to => "recommends#index"
end
