class Hoopla::User < ActiveRecord::Base
  has_many :metric_values

  validates :href, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
