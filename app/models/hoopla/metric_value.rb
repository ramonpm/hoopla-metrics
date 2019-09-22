class Hoopla::MetricValue < ActiveRecord::Base
  belongs_to :metric
  belongs_to :user

  validates :href, presence: true, uniqueness: true
  validates :user, presence: true
  validates :metric, presence: true

  validates_uniqueness_of :user_id, scope: :metric_id
end
