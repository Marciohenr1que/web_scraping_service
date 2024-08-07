class ScrapedDatum < ApplicationRecord
    belongs_to :user, optional: true
    validates :brand, :model, :price, :url, presence: true
end
