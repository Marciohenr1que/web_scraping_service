require 'rails_helper'

RSpec.describe ScrapedDatum, type: :model do
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to validate_presence_of(:brand) }
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:url) }
end