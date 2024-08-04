require_relative '../../lib/notification_services_pb'
class ScrapedDataController < ApplicationController
  def scrape
    repository = ScrapedDataRepository.new
    
    # Inicialização do notification_client
    notification_stub = Notification::NotificationService::Stub.new('localhost:50052', :this_channel_is_insecure)
    
    scraping_service = WebScrapingServices.new(repository, notification_stub)
    
    url = params[:url]
    if url.present?
      scraping_service.scrape_data(url)
      render json: { message: 'Scraping initiated successfully' }, status: :ok
    else
      render json: { error: 'URL parameter is required' }, status: :bad_request
    end
  end
end
