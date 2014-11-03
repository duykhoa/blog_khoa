Rails.application.routes.draw do

  resources :email_subscribes

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :articles, only: [:index, :show, :search]
  devise_for :users

  namespace :admin do
    resources :articles
  end

  get 'feed', to: 'articles#index', defaults: {format: 'rss'}, as: :feed
  get '/(page/:page)' => 'articles#index', as: :index_seo
  get 'search/category/:category_name', to: 'articles#category_index', as: :category_index
  get 'search/category/:category_name(/query/:query)(/page/:page)', to: 'articles#category_index_seo', as: :category_index_seo
  get 'search' => 'articles#search'
  get 'search/:query(/page/:page)' => 'articles#search_seo_friendly', as: :search_seo_friendly
  get 'aboutme' => 'about_mes#index'

  get '*a', to: 'errors#error_404'
  root 'articles#index'
end
