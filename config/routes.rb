Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

end