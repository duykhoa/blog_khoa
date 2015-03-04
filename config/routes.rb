Rails.application.routes.draw do

  namespace :v2_admin do
    resources :assets, only: :create
    resources :blog_settings, only: :index
    resources :categories, only: :index
    resources :email_subscribers, only: [:index]
    resources :categories, only: [:index, :create, :update]
    resources :abouts, only: [:show,:edit, :update] do
      get 'me', to: 'abouts#show', on: :collection
    end

    patch 'blog_settings/updates' => 'blog_settings#update', as: :update_blog_settings
    get 'email_subscribers/index'
  end

  resources :email_subscribes, only: [:index, :create]
  resources :comments, only: [:create]

  resources :articles, only: [:index, :show]
  devise_for :users

  namespace :admin do
    resources :articles
  end

  get 'about' => 'abouts#index'
  get '/search(/category/:category_name)' => 'articles#search', as: :seo_search

  get 'feed', to: 'articles#index', defaults: {format: 'rss'}, as: :feed
  get '/(page/:page)' => 'articles#index', as: :index_seo

  root 'articles#index'

  namespace :v2_admin do
    root 'homes#index'
    resources "homes"
    resources "articles"
  end

  get '*a', to: 'errors#error_404' if Rails.env.production?
end
