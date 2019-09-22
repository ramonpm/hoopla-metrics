FactoryBot.define do
  factory :metric_value, class: Hoopla::MetricValue do
    user
    metric
    href { "https://api.hoopla.net/metrics/46c22140-3624-416b-93b0-70b9979ea8c8/values/#{SecureRandom.uuid}" }
    value { 17 }
  end
end
