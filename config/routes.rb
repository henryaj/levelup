Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  get 'reviews/pending', action: :show_pending, controller: 'reviews', as: 'pending_reviews'
  resources :reviews, except: :edit

  root "pages#home"
end
