require 'rails_helper'

RSpec.describe Hoopla::Metric, type: :model do
  context 'with valid attributes' do
    let(:metric) { build(:metric) }
    
    it 'is valid' do
      expect(metric).to be_valid
    end
  end

  context 'with invalid attributes' do
    let(:metric) { build(:metric, name: nil, href: nil) }
    
    it 'is invalid' do
      expect(metric).to be_invalid
      expect(metric.errors.full_messages).to eq(["Href can't be blank", "Name can't be blank"])
    end

    it 'href should be unique' do
      metric = create(:metric, href: 'https://api.hoopla.net/metrics/1')
      duplicated_metric = build(:metric, href: metric.href)
      expect(duplicated_metric).to be_invalid
      expect(duplicated_metric.errors.full_messages).to eq(['Href has already been taken'])
    end
  end
end
