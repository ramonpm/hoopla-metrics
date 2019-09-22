require 'rails_helper'

describe Hoopla::UsersSynchronizer do
  it 'imports a new user into the database' do
    hash = {
      href: 'https://api/users/1',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }.with_indifferent_access
    expect {
      Hoopla::UsersSynchronizer.sync([hash])
    }.to change { Hoopla::User.count }.by(1)
    expect(Hoopla::User.first.href).to eq(hash['href'])
  end
end
