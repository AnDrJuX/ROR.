class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Created Station: #{@name}."
  end

  def add_train(train)
    self.trains << train
    puts "Train #{train.number} added to the station #{self.name}."
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
    puts "Train #{train} delete from the station #{self.name}."
  end

end


class Route
  attr_accessor :stations

  def initialize(first:, last:)
    @stations = [first, last]
    puts "Route created: #{self}, from: #{first.name} to #{last.name}."
  end

  def add_station_to_list(station)
    self.stations.insert(-2, station)
    puts "Station #{station.name} added to the route #{self}."
  end

  def delete_station_to_list(station)
    self.stations.delete(station)
    puts "Station #{station.name} removed from the route #{self}."
  end

  def station_list
    self.stations.each_with_index do |station, index|
      puts "#{index + 1}: #{station.name}"
    end
  end
end


class Train
  attr_accessor :route
  attr_reader :number, :type, :wagons, :current_station_index, :speed

  def initialize(number:, type:, num_of_wagons:)
    @number = number
    @type = type
    @num_of_wagons = num_of_wagons
    @speed  = 0
    @route  = route
    @current_station_index = current_station_index
  end

  def speed
    self.speed += 30
  end


  def speed_current
    puts "Current speed: #{self.speed}"
  end

  def speed_down
    self.speed = 0
  end

  def num_of_wagons
    puts "Number of wagons: #{self.num_of_wagons}"
  end

  def add_wagons
    if speed == 0
      self.num_of_wagons += 1
      puts "Number of wagons: #{self.num_of_wagons}"
    end
  end

  def delete_wagons
    if speed == 0
      self.num_of_wagons -= 1 until num_of_wagons.empty?
      puts "Number of wagons: #{self.num_of_wagons}"
    end
  end

  def take_route(route)
    self.route = route
    self.current_station_index = 0
    self.route.stations.first.add_train(self)
    puts "Route #{route.stations.first.name}---#{route.stations.last.name} taken."
  end

  def move_next_station
    if self.current_station_index == self.route.stations.size - 1
      puts "Error. #{current_station.name} is the ending station."
    else
      current_station.go_and_delete(self)
      self.current_station_index += 1
      current_station.add_train(self)
      puts "Train #{self.number} moved to station #{current_station.name}."
    end
  end

  def move_back_station
    if self.current_station_index == 0
      puts "Error. #{current_station.name} is the ending station."
    else
      current_station.go_and_delete(self)
      self.current_station_index -= 1
      current_station.add_train(self)
      puts "Train #{self.number} moved to station #{current_station.name}."
    end
  end

  def current_station
    self.route.stations[current_station_index]
  end
end