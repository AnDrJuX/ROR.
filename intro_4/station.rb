class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    self.trains << train
  end

  def current_trainlist
    self.trains.each do |train|
      puts train
    end
  end

  def trainlist(type)
    puts "Trains with type #{type} on station #{self.name}:"
    self.trains.each do |train|
      puts "#{train.number}" if train.type == type
    end
  end

  def go_and_delete(train)
    self.trains.delete(train)
    puts "Train #{train} deleted from the station #{self.name}."
  end
end