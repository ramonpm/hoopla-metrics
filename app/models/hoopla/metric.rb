class Hoopla::Metric < ActiveRecord::Base
  has_many :metric_values

  validates :href, presence: true, uniqueness: true
  validates :name, presence: true
end
