class ScrapedDataController < ApplicationController
  def scrape
    repository = ScrapedDataRepository.new
    scraping_service = WebScrapingServices.new(repository)
    
    url = params[:url]
    if url.present?
      scraping_service.scrape_data(url)
      render json: { message: 'Scraping initiated successfully' }, status: :ok
    else
      render json: { error: 'URL parameter is required' }, status: :bad_request
    end
  end
end