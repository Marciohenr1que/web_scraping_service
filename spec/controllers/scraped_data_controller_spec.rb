# spec/controllers/scraped_data_controller_spec.rb
require 'rails_helper'

RSpec.describe ScrapedDataController, type: :controller do
  let(:user_id) { '785' }
  let(:valid_headers) { { 'X-User-Id' => user_id } }
  let(:repository) { instance_double(ScrapedDataRepository) }
  let(:notification_stub) { instance_double(Notification::NotificationService::Stub) }
  let(:scraping_service) { instance_double(WebScrapingServices) }

  before do
    allow(ScrapedDataRepository).to receive(:new).and_return(repository)
    allow(Notification::NotificationService::Stub).to receive(:new).and_return(notification_stub)
    allow(WebScrapingServices).to receive(:new).with(repository, notification_stub).and_return(scraping_service)
  end

  describe 'GET #index' do
    let(:scraped_data) { [{ brand: 'Brand', model: 'Model', price: '1000', url: 'http://example.com' }] }

    before do
      allow(repository).to receive(:all).with(user_id).and_return(scraped_data)
      request.headers.merge!(valid_headers)
      get :index
    end

    it 'returns the scraped data' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(scraped_data.as_json)
    end

    it 'calls the repository with the correct user_id' do
      expect(repository).to have_received(:all).with(user_id)
    end
  end

  describe 'POST #scrape' do
    let(:url) { 'http://example.com' }
    
    context 'with valid parameters' do
      before do
        allow(scraping_service).to receive(:scrape_data)
        request.headers.merge!(valid_headers)
        post :scrape, params: { url: url }
      end

      it 'initiates scraping' do
        expect(scraping_service).to have_received(:scrape_data).with(url, user_id)
      end

      it 'returns a success message' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Scraping initiated successfully' })
      end
    end

    context 'with missing URL' do
      before do
        allow(scraping_service).to receive(:scrape_data)
        request.headers.merge!(valid_headers)
        post :scrape, params: { url: nil }
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'URL and User ID parameters are required' })
      end

      it 'does not initiate scraping' do
        expect(scraping_service).not_to have_received(:scrape_data)
      end
    end

    context 'with missing User ID' do
      before do
        allow(scraping_service).to receive(:scrape_data)
        post :scrape, params: { url: url }
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'URL and User ID parameters are required' })
      end

      it 'does not initiate scraping' do
        expect(scraping_service).not_to have_received(:scrape_data)
      end
    end
  end
end
