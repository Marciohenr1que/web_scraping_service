require 'selenium-webdriver'
require 'nokogiri'
require 'grpc'
require_relative '../../lib/notification_services_pb'


class WebScrapingServices
  GOOGLEBOT_USER_AGENT = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

  def initialize(scraped_data_repository, notification_client, html_parser = Nokogiri::HTML)
    @scraped_data_repository = scraped_data_repository
    @notification_client = notification_client
    @html_parser = html_parser
  end

  def random_wait_time
    rand(3..7)
  end

  def human_like_interactions(driver)
    driver.manage.window.resize_to(rand(800..1200), rand(600..900))
    driver.manage.window.move_to(rand(0..100), rand(0..100))
    sleep random_wait_time
  end

  def scrape_data(url)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument("--user-agent=#{GOOGLEBOT_USER_AGENT}")

    driver = Selenium::WebDriver.for :chrome, options: options

    driver.navigate.to url
    human_like_interactions(driver)

    # tempo de espera
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { driver.title.length > 0 }

    html_doc = @html_parser.parse(driver.page_source)
    body_content = html_doc.at('body')

    # Obtendo os dados dos elementos específicos
    brand = body_content.at_css('#VehicleBasicInformationTitle')&.text&.strip
    model = body_content.at_css('#VehicleBasicInformationDescription')&.text&.strip
    price_text = body_content.at_css('#vehicleSendProposalPrice')&.text&.strip

    # numérico
    price = price_text&.gsub(/[^\d,]/, '')&.gsub(',', '.')&.to_f

    data = {
      brand: brand,
      model: model,
      price: price,
      url: url
    }

    # debug
    Rails.logger.debug "Brand: #{brand}"
    Rails.logger.debug "Model: #{model}"
    Rails.logger.debug "Price: #{price}"

    # Adicione uma verificação para os dados
    if data.values.any?(&:blank?)
      Rails.logger.debug "Data is missing: #{data.inspect}"
    else
      @scraped_data_repository.create(data)
      notify("Web scraping completed successfully for URL: #{url}")
    end

    driver.quit
  end

  private

  def notify(message)
    request = Notification::WebscrapingNotificationRequest.new(message: message)
    response = @notification_client.send_webscraping_notification(request)
    if response.success
      Rails.logger.debug "Notification sent successfully"
    else
      Rails.logger.error "Failed to send notification"
    end
  end
end

# notification_client
notification_stub = Notification::NotificationService::Stub.new('localhost:50052', :this_channel_is_insecure)
scraped_data_repository = ScrapedDataRepository.new
web_scraping_service = WebScrapingServices.new(scraped_data_repository, notification_stub)



