class Station
  attr_reader :title

  TITLE = /\A[a-z]\z/i

  @@stations = {}

  def initialize(title)
    @title = title
    @trains = []
    @@stations[title] = self
    validate!
  rescue
    raise
  end

  def valid?
    validate!
  rescue
    false
  end

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations[name]
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_train_list
    @trains.each { |t| puts t }
  end

  def trains_by_type(tr_type)
    arr = @trains.find_all { |t| t.type == tr_type }
    arr.size
  end

  protected

  def validate!
    raise "Name should be 1 or more symbol!" if self.title !~ TITLE
    true
  end


end