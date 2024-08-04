require 'faraday'
require 'nokogiri'

class WebScrapingService
  def initialize(scraped_data_repository)
    @scraped_data_repository = scraped_data_repository
  end

  def scrape_data(url)
    response = Faraday.get(url)
    html_doc = Nokogiri::HTML(response.body)

    # Ajuste os seletores conforme necessário
    # Estes seletores são apenas exemplos. Você precisa inspecionar o HTML da página para encontrar os corretos.
    brand = html_doc.at_css('.VehicleBasicInformationTitle')&.text&.strip
    model = html_doc.at_css('.VehicleBasicInformationDescription')&.text&.strip
    price_text = html_doc.at_css('.vehicleSendProposalPrice')&.text&.strip

    # numero
    price = price_text&.gsub(/[^\d,]/, '')&.gsub(',', '.')&.to_f

    data = {
      brand: brand,
      model: model,
      price: price,
      url: url
    }

    @scraped_data_repository.create(data)
  end
end
