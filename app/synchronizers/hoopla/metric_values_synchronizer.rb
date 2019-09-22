class Hoopla::MetricValuesSynchronizer < Synchronizer
  def self.import(hash)
    user = Hoopla::User.find_by!(href: hash['owner']['href'])
    metric = Hoopla::Metric.find_by!(href: hash['metric']['href'])
    metric_value = Hoopla::MetricValue.find_or_initialize_by(href: hash['href'])
    metric_value.user = user
    metric_value.metric = metric
    metric_value.value = hash['value']
    metric_value.save
  end
end
