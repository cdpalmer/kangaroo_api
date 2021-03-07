Rails.application.routes.draw do
  resources :searches

  # When I build a UI...
  root 'searches#index'
end
