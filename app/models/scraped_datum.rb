class ScrapedDatum < ApplicationRecord
    validates :brand, :model, :price, :url, presence: true
end
