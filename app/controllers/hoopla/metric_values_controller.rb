class Hoopla::MetricValuesController < ApplicationController
  def index
    @metric = get_metric
  end

  private

  def get_metric
    @metric ||= Hoopla::Metric.find(params[:metric_id])
  end
end
