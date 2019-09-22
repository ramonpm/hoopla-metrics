require 'rails_helper'

RSpec.describe Hoopla::User, type: :model do
  context 'with valid attributes' do
    let(:user) { build(:user) }
    
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  context 'with invalid attributes' do
    let(:user) { build(:user, href: nil, first_name: nil, last_name: nil) }
    
    it 'is invalid' do
      expect(user).to be_invalid
      expect(user.errors.full_messages).to eq(["Href can't be blank", "First name can't be blank", "Last name can't be blank"])
    end

    it 'href should be unique' do
      user = create(:user)
      duplicated_user = build(:user, href: user.href)
      expect(duplicated_user).to be_invalid
      expect(duplicated_user.errors.full_messages).to eq(['Href has already been taken'])
    end
  end

  describe '#name' do
    it 'returns the full name' do
      user = build(:user, first_name: 'Ramon', last_name: 'Marques')
      expect(user.name).to eq('Ramon Marques')
    end
  end

  describe '#metric_value_of' do
    let(:metric_value) { create(:metric_value, value: 10.0) }
    let(:metric) { metric_value.metric }
    let(:user) { metric_value.user }

    it 'returns the metric_value of a given metric' do
      expect(user.metric_value_of(metric)).to eq(10.0)
    end

    it 'returns 0 if the user has no value for the given metric' do
      another_user = build(:user)
      expect(another_user.metric_value_of(metric)).to eq(0.0)
    end
  end
end
