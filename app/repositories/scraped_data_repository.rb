class ScrapedDataRepository
  def create(data)
    ScrapedDatum.create!(data)
  end
  
  def all
    ScrapedDatum.all
  end
end