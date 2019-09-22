class Hoopla::MetricValue < ActiveRecord::Base
  belongs_to :metric
  belongs_to :user

  validates :href, uniqueness: true
  validates :user, presence: true
  validates :metric, presence: true

  validates_uniqueness_of :user_id, scope: :metric_id

  before_create :hoopla_create

  private

  def hoopla_create
    response = Hoopla::MetricValuesSynchronizer.push(self)
    self.href = response['href']
  rescue StandardError
    false
  end
end
