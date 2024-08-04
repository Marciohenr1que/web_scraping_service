class ScrapedDataSerializer < ActiveModel::Serializer
    attributes :id, :brand, :model, :price, :url
  end