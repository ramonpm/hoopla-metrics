class Hoopla::MetricsController < ApplicationController
  before_action :sync_hoopla_metrics, only: [:index]

  def index
    @metrics = Hoopla::Metric.all
  end

  def sync_hoopla_metrics
    metrics_hash_list = get_client.list_metrics
    Hoopla::MetricsSynchronizer.sync(metrics_hash_list)
  end
end
