class Station

  include InstanceCounter

  @@stations = []

  def self.all
    @@stations
  end

  def self.find(title)
    @@stations[title]
  end

  attr_reader :title

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
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

  def each_train
    @trains.each { |train| yield train }
  end

  protected

  def validate!
    raise "Название станции не может быть пустым!" if title.nil? || title.length == 0
    true
  end

end