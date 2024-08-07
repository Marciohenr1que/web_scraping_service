require_relative '../../lib/notification_services_pb'

class ScrapedDataController < ApplicationController
  def index
    user_id = request.headers['X-User-Id']
    render json: ScrapedDataRepository.new.all(user_id)
  end

  def scrape
    repository = ScrapedDataRepository.new
    
    # Inicialização do notification_client
    notification_stub = Notification::NotificationService::Stub.new('localhost:50052', :this_channel_is_insecure)
    
    scraping_service = WebScrapingServices.new(repository, notification_stub)
    
    url = params[:url]
    user_id = request.headers['X-User-Id']

    if url.present? && user_id.present?
      scraping_service.scrape_data(url, user_id)
      render json: { message: 'Scraping initiated successfully' }, status: :ok
    else
      render json: { error: 'URL and User ID parameters are required' }, status: :bad_request
    end
  end
end
