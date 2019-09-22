class Hoopla::MetricValuesController < ApplicationController
  before_action :set_hoopla_metric_value, only: [:show, :edit, :update, :destroy]

  # GET /hoopla/metric_values
  # GET /hoopla/metric_values.json
  def index
    @metric = get_metric
    @hoopla_metric_values = Hoopla::MetricValue.all
  end

  # GET /hoopla/metric_values/1
  # GET /hoopla/metric_values/1.json
  def show
  end

  # GET /hoopla/metric_values/new
  def new
    @hoopla_metric_value = Hoopla::MetricValue.new
  end

  # GET /hoopla/metric_values/1/edit
  def edit
  end

  # POST /hoopla/metric_values
  # POST /hoopla/metric_values.json
  def create
    @hoopla_metric_value = Hoopla::MetricValue.new(hoopla_metric_value_params)

    respond_to do |format|
      if @hoopla_metric_value.save
        format.html { redirect_to @hoopla_metric_value, notice: 'Metric value was successfully created.' }
        format.json { render :show, status: :created, location: @hoopla_metric_value }
      else
        format.html { render :new }
        format.json { render json: @hoopla_metric_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hoopla/metric_values/1
  # PATCH/PUT /hoopla/metric_values/1.json
  def update
    respond_to do |format|
      if @hoopla_metric_value.update(hoopla_metric_value_params)
        format.html { redirect_to @hoopla_metric_value, notice: 'Metric value was successfully updated.' }
        format.json { render :show, status: :ok, location: @hoopla_metric_value }
      else
        format.html { render :edit }
        format.json { render json: @hoopla_metric_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hoopla/metric_values/1
  # DELETE /hoopla/metric_values/1.json
  def destroy
    @hoopla_metric_value.destroy
    respond_to do |format|
      format.html { redirect_to hoopla_metric_values_url, notice: 'Metric value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_metric
    @metric ||= Hoopla::Metric.find(params[:metric_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_hoopla_metric_value
    @hoopla_metric_value = Hoopla::MetricValue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hoopla_metric_value_params
    params.require(:hoopla_metric_value).permit(:href, :metric_id, :user_id, :value)
  end
end
