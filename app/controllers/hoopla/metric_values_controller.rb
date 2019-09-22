class Hoopla::MetricValuesController < ApplicationController
  before_action :set_hoopla_metric
  before_action :set_hoopla_metric_value, only: [:show, :edit, :update, :destroy]
  before_action :set_hoopla_user, only: [:new, :edit]
  before_action :sync_hoopla_metric_values, only: [:index]

  # GET /hoopla/metric_values
  def index
    @users = Hoopla::User.all
  end

  # GET /hoopla/metric_values/1
  def show
  end

  # GET /hoopla/metric_values/new
  def new
    @hoopla_metric_value = Hoopla::MetricValue.new
    @hoopla_metric_value.metric = @metric
    @hoopla_metric_value.user = @user
  end

  # GET /hoopla/metric_values/1/edit
  def edit
  end

  # POST /hoopla/metric_values
  def create
    @hoopla_metric_value = Hoopla::MetricValue.new(hoopla_metric_value_params)

    respond_to do |format|
      if @hoopla_metric_value.save
        format.html { redirect_to hoopla_metric_metric_values_url(@metric), notice: 'Metric value was successfully created.' }
      else
        @user = @hoopla_metric_value.user
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /hoopla/metric_values/1
  def update
    respond_to do |format|
      if @hoopla_metric_value.update(hoopla_metric_value_params)
        format.html { redirect_to hoopla_metric_metric_values_url(@metric), notice: 'Metric value was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /hoopla/metric_values/1
  def destroy
    @hoopla_metric_value.destroy
    respond_to do |format|
      format.html { redirect_to hoopla_metric_values_url, notice: 'Metric value was successfully destroyed.' }
    end
  end

  private

  def set_hoopla_metric
    @metric ||= Hoopla::Metric.find(params[:metric_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_hoopla_metric_value
    @hoopla_metric_value = Hoopla::MetricValue.find(params[:id])
  end

  def set_hoopla_user
    @user ||= Hoopla::User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hoopla_metric_value_params
    params.require(:hoopla_metric_value).permit(:metric_id, :user_id, :value)
  end

  def sync_hoopla_metric_values
    metric = set_hoopla_metric
    metric_values_hash_list = get_client.list_metric_values_of(metric.href)
    Hoopla::MetricValuesSynchronizer.sync(metric_values_hash_list)
  end
end
