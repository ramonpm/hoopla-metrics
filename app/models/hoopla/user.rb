class Hoopla::User < ActiveRecord::Base
  has_many :metric_values

  validates :href, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def metric_value_of(metric)
    metric_value = metric_values.find_by(metric: metric)
    metric_value.try(:value) || 0.0
  end
end
