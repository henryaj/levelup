Rails.application.routes.draw do
  resources :reviews

  root "pages#home"
end
