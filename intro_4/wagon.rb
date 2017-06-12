class Wagon
  attr_reader :type

  def type
    @type = self.class.name
  end
end
