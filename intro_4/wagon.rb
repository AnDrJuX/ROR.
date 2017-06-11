class Wagon
  attr_accessor :type

  def type
    @type = self.class.name
  end
end
