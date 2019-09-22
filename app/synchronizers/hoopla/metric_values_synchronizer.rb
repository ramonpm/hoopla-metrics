class Hoopla::MetricValuesSynchronizer < Synchronizer
  def self.import(hash)
    user_kind = hash['owner']['kind'] == 'user'
    if user_kind
      user = Hoopla::User.find_by!(href: hash['owner']['href'])
      metric = Hoopla::Metric.find_by!(href: hash['metric']['href'])
      metric_value = Hoopla::MetricValue.find_or_initialize_by(href: hash['href'])
      metric_value.user = user
      metric_value.metric = metric
      metric_value.value = hash['value']
      metric_value.save
    end
  end

  def self.push(metric_value)
    metric = metric_value.metric

    payload = {
      owner: {
        kind: 'user',
        href: metric_value.user.href
      },
      value: metric_value.value.to_f
    }

    client = HooplaClient.hoopla_client
    client.create_metric_value(metric.href, payload)
  end

  def self.update(metric_value)
    payload = {
      value: metric_value.value.to_f
    }

    client = HooplaClient.hoopla_client
    client.update_metric_value(metric_value.href, payload)
  end
end
