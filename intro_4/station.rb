class Station
  attr_reader :title, :trains

  def initialize(title:)
    @title = title
    @trains = []
    puts "Station created: #{self}, title: #{self.title}."
  end

  def add_train(train)
    self.trains << train
    puts "Train #{train.number} added to the station #{self.title}."
  end

  def show_all_trains
    self.trains.each do |train|
      puts "#{train.number}, type: #{train.type}."
    end
  end

  def type_list(type)
    puts "Trains with type #{type} on station #{self.title}:"
    self.trains.each do |train|
      puts "#{train.number}" if train.type == type
    end
  end

  def send_train(train)
    self.trains.delete(train)
    puts "Train #{train.number} deleted from the station #{self.title}."
  end
end