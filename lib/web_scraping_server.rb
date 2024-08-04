require 'grpc'
require_relative '../lib/web_scraping_services_pb'
# require_relative '../app/services/web_scraping_service'
class WebScrapingServiceServer < Webscraping::WebScrapingService::Service
  def initialize(scraped_data_repository, notification_client)
    @scraped_data_repository = scraped_data_repository
    @notification_client = notification_client
  end

  def scrape_data(scrape_request, _unused_call)
    @service.scrape_data(scrape_request.url)
    Webscraping::ScrapeResponse.new(success: true, message: 'Scraping completed successfully')
  rescue => e
    Webscraping::ScrapeResponse.new(success: false, message: e.message)
  end
end

def start_server
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50053', :this_port_is_insecure)
  s.handle(WebScrapingServiceServer.new)
  puts "Server is listening on port 50053"
  s.run_till_terminated
end

start_server