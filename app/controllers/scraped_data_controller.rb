class ScrapedDataController < ApplicationController
    def index
      repository = ScrapedDataRepository.new
      @scraped_data = repository.all
      render json: @scraped_data
    end
  end