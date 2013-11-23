Asumibot::Application.routes.draw do
  resources :patients, only: [:show]


  devise_for :admins

  namespace :admins do
    resources :serifs, :except => [:show]
    resources :youtubemovies, :except => [:show, :destroy, :new, :create]
    resources :niconicomovies, :except => [:show, :destroy, :new, :create]
  end

  root :to => "admins/serifs#index"
end
