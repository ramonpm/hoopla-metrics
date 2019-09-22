FactoryBot.define do
  factory :metric, class: Hoopla::Metric do
    href { "https://api.hoopla.net/metrics/#{SecureRandom.uuid}" }
    name { '# Opps Closed MTD' }
  end
end
