require 'selenium-webdriver'
require 'nokogiri'
require 'faker'

class WebScrapingServices
  GOOGLEBOT_USER_AGENT = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

  def initialize(scraped_data_repository, html_parser = Nokogiri::HTML)
    @scraped_data_repository = scraped_data_repository
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
    wait = Selenium::WebDriver::Wait.new(timeout: 1)
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

    #  debug
    Rails.logger.debug "Brand: #{brand}"
    Rails.logger.debug "Model: #{model}"
    Rails.logger.debug "Price: #{price}"

    # Adicione uma verificação para os dados
    if data.values.any?(&:blank?)
      Rails.logger.debug "Data is missing: #{data.inspect}"
    else
      @scraped_data_repository.create(data)
    end

    driver.quit
  end
end



