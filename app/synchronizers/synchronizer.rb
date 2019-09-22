class Synchronizer
  def self.sync(objects)
    objects.each { |object| import(object) }
  end

  def self.import(object)
    raise 'not implemented!'
  end
end
