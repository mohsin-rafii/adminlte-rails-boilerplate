Rails.application.routes.draw do
  resources :comments
  resources :posts
  root to: 'welcome#home'
  #welcome/change_subscribe_status
  get 'welcome/change_subscribe_status' => 'welcome#change_subscribe_status'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
