Rails.application.routes.draw do
  root to: 'home#index'
  resources :twitter_profiles, only: [:index, :new, :create]
end
