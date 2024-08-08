require 'rails_helper'

RSpec.describe ScrapedDataRepository, type: :model do
  let(:repository) { described_class.new }
  let(:user_id) { 1 }
  let(:data) { { brand: 'Toyota', model: 'Corolla', price: 15000, url: 'http://example.com', user_id: } }

  describe '#create' do
    it 'creates a new ScrapedDatum record' do
      expect { repository.create(data) }.to change { ScrapedDatum.count }.by(1)
    end

    it 'creates a record with the correct attributes' do
      scraped_datum = repository.create(data)
      expect(scraped_datum.brand).to eq('Toyota')
      expect(scraped_datum.model).to eq('Corolla')
      expect(scraped_datum.price).to eq(15000)
      expect(scraped_datum.url).to eq('http://example.com')
      expect(scraped_datum.user_id).to eq(user_id)
    end
  end

  describe '#all' do
    before do
      @datum1 = ScrapedDatum.create!(brand: 'Honda', model: 'Civic', price: 18000, url: 'http://example1.com', user_id: 1)
      @datum2 = ScrapedDatum.create!(brand: 'Ford', model: 'Mustang', price: 30000, url: 'http://example2.com', user_id: 1)
      @datum3 = ScrapedDatum.create!(brand: 'Chevrolet', model: 'Camaro', price: 35000, url: 'http://example3.com', user_id: 2)
    end

    it 'returns all ScrapedDatum records for a given user_id' do
      result = repository.all(user_id)
      expect(result).to contain_exactly(@datum1, @datum2)
    end

    it 'does not return records for a different user_id' do
      result = repository.all(user_id)
      expect(result).not_to include(@datum3)
    end
  end
end
