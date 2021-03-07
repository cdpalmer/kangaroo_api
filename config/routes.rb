Rails.application.routes.draw do
  resources :searches
  resources :movies
  resources :showtimes
  resources :theaters
end
