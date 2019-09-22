class Hoopla::Metric < ActiveRecord::Base
  validates :href, presence: true, uniqueness: true
  validates :name, presence: true
end
