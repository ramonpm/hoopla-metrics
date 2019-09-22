class Hoopla::MetricValue < ActiveRecord::Base
  belongs_to :metric
  belongs_to :user

  validates :href, presence: true, uniqueness: true
  validates :user, presence: true
  validates :metric, presence: true

  validates_uniqueness_of :user_id, scope: :metric_id

  before_validation :default_href
  before_create :hoopla_create

  private

  def default_href
    self.href ||= 'not_synced' if self.new_record?
  end

  def hoopla_create
    
  end
end
