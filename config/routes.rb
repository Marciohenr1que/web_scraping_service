Rails.application.routes.draw do
 
  get '/scraped_data', to: 'scraped_data#index'


  post '/scrape', to: 'scraped_data#scrape'
end