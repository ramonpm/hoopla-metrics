require 'rails_helper'

RSpec.describe Hoopla::MetricValue, type: :model do
  context 'with valid attributes' do
    let(:metric_value) { build(:metric_value) }
    
    it 'is valid' do
      expect(metric_value).to be_valid
    end
  end

  context 'with invalid attributes' do
    let(:metric_value) { build(:metric_value, href: nil, user: nil, metric: nil) }
    
    it 'is invalid' do
      expect(metric_value).to be_invalid
      expect(metric_value.errors.full_messages).to eq(["User can't be blank", "Metric can't be blank"])
    end

    it 'href should be unique' do
      metric_value = create(:metric_value)
      duplicated_metric_value = build(:metric_value, href: metric_value.href)
      expect(duplicated_metric_value).to be_invalid
      expect(duplicated_metric_value.errors.full_messages).to eq(['Href has already been taken'])
    end

    it 'user should be unique in the scope of the metric' do
      metric_value = create(:metric_value)
      duplicated_metric_value = build(:metric_value, user: metric_value.user, metric: metric_value.metric)
      expect(duplicated_metric_value).to be_invalid
      expect(duplicated_metric_value.errors.full_messages).to eq(["Href has already been taken", "User has already been taken"])
    end
  end
end
