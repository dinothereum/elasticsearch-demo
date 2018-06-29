Rails.application.routes.draw do
  root "articles#index"

  resources :articles
  get 'search', to: 'search#search'
  get 'normal_search', to: 'search#normal_search'
end
