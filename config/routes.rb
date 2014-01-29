Asumibot::Application.routes.draw do
  resources :patients, only: [:show, :index]
  resources :recommends, only: [:index]
  resources :movies, only: [:index]
  match "/movies/show_niconico/:id" => "movies#show_niconico", :as => :niconico
  match "/movies/show_youtube/:id" => "movies#show_youtube", :as => :youtube

  devise_for :admins

  namespace :admins do
    resources :serifs, :except => [:show]
    resources :youtubemovies, :except => [:show, :destroy, :new, :create]
    resources :niconicomovies, :except => [:show, :destroy, :new, :create]
  end

  root :to => "recommends#index"
end
