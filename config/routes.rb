Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'
  get 'terms', to: 'static#terms'
  get 'thanks', to: 'static#thanks', as: 'thanks'

  resources :places do
    member do
      patch 'transition'
    end
  end

  resources :contributors
  resources :builds

  resource :embed

  root to: 'places#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
