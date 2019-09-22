class Hoopla::MetricsSynchronizer < Synchronizer
  def self.import(hash)
    metric = Hoopla::Metric.find_or_initialize_by(href: hash['href'])
    metric.name = hash['name']
    metric.save
  end
end
