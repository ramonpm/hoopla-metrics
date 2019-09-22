class Hoopla::MetricsController < ApplicationController
  def index
    @metrics = Hoopla::Metric.all
  end
end
