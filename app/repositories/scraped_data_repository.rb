class ScrapedDataRepository
  def create(data)
    ScrapedDatum.create!(data)
  end

  def all(user_id)
    ScrapedDatum.where(user_id:)
  end
end