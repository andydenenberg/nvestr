Stc::Application.routes.draw do

  resources :stocks do
    collection do
      get 'manage_list'
      get 'lookup'
    end
  end

  resources :attachments 

  resources :comments do
    member do
      get 'modify'
    end
  end

  resources :posts do
    collection do
      get 'add_comment'
      get 'add_attachment'
    end
  end
    
#  authenticated :user do
#    root :to => 'home#index'
#    root :to => 'home#welcome'
#  end

  root :to => 'stocks#index'
  
  devise_for :users
  resources :users
  
  get 'home/welcome' => 'home#welcome', :as => :welcome
  get 'home/index' => 'home#index', :as => :index
  get 'home/news' => 'home#news', :as => :news
  get 'home/pictures' => 'home#pictures', :as => :pictures
  get 'home/media' => 'home#media', :as => :media
  
  get 'home/start' => 'home#start', :as => :start
  
end