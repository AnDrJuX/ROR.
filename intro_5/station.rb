class Station
  attr_reader :title

  @@stations = {}

  def initialize(title)
    @title = title
    @trains = []
    @@stations[title] = self
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
end