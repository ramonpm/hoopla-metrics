class Hoopla::UsersSynchronizer < Synchronizer
  def self.import(hash)
    metric = Hoopla::User.find_or_initialize_by(href: hash['href'])
    metric.first_name = hash['first_name']
    metric.last_name = hash['last_name']
    metric.save
  end
end
