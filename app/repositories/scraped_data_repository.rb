class ScrapedDataRepository
    def create(data)
      ScrapedData.create!(data)
    end
  
    def all
      ScrapedData.all
    end
  end