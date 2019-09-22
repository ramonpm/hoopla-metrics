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
end
