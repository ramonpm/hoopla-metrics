FactoryBot.define do
  factory :user, class: Hoopla::User do
    href { "https://api.hoopla.net/users/#{SecureRandom.uuid}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
