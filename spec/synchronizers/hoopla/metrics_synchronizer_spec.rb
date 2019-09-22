require 'rails_helper'

describe Hoopla::MetricsSynchronizer do
  it 'imports a new metric into the database' do
    hash = {
      href: 'https://api/metrics/1',
      name: 'Pipeline'
    }.with_indifferent_access
    expect {
      Hoopla::MetricsSynchronizer.sync([hash])
    }.to change { Hoopla::Metric.count }.by(1)
    expect(Hoopla::Metric.first.href).to eq(hash['href'])
  end
end
