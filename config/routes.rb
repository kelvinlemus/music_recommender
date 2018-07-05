Rails.application.routes.draw do
  root to: 'home#index'
  resources :twitter_profiles, except: [:destroy, :edit, :update]
end
