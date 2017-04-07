Rails.application.routes.draw do
  resources :places,       only: %w(new index)
  resources :contributors, only: %w(new create)
  resources :builds,       only: %w(new create)

  resource :embed

  namespace :admin do
    root to: redirect("/admin/places?state=awaiting_review", status: 302)

    resources :places, only: %w(index show edit update)
    resources :place_states, only: %w(update)
  end

  get 'terms',  to: 'static#terms'
  get 'thanks', to: 'static#thanks', as: 'thanks'

  root to: 'places#index'
end
