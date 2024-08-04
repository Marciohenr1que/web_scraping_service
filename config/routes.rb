Rails.application.routes.draw do
  # Rota para obter os dados raspados
  get '/scraped_data', to: 'scraped_data#index'

  # Rota para iniciar o scraping
  post '/scrape', to: 'scraped_data#scrape'
end