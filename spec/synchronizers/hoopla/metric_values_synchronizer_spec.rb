require 'rails_helper'

describe Hoopla::MetricValuesSynchronizer do
  it 'imports a new metric value into the database' do
    hash = {
      "href" => "https://api.hoopla.net/metrics/46c22140-3624-416b-93b0-70b9979ea8c8/values/ca27c422-bf5c-4156-b753-78b350e33c06",
      "metric" => {
        "href" => "https://api.hoopla.net/metrics/46c22140-3624-416b-93b0-70b9979ea8c8"
      },
      "owner" => {
        "kind" => "user",
        "href" => "https://api.hoopla.net/users/743b48e1-f9a7-4cc1-8443-3513571b68f1"
      },
      "value" => 17.0
    }
    create(:user, href: hash['owner']['href'])
    create(:metric, href: hash['metric']['href'])
    expect {
      Hoopla::MetricValuesSynchronizer.sync([hash])
    }.to change { Hoopla::MetricValue.count }.by(1)
    expect(Hoopla::MetricValue.first.href).to eq(hash['href'])
  end
end
