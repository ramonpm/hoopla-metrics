module Hoopla::MetricValuesHelper
  def metric_value_link_for(user, metric)
    metric_value = user.metric_values.find_by(metric: metric)
    path = metric_value ? edit_hoopla_metric_metric_value_path(metric, metric_value, user_id: user.id) : new_hoopla_metric_metric_value_path(metric, user_id: user.id)
    link_to user.name, path
  end

  def form_path_of(metric_value)
    return hoopla_metric_metric_value_path(metric_value.metric, metric_value) if metric_value.id
    hoopla_metric_metric_values_path(metric_value.metric)
  end
end
