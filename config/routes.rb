Rails.application.routes.draw do
  resources :scraped_data, only: [:index]
end