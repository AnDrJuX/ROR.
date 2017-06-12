class Train
  attr_accessor :current_station_index
  attr_reader :number, :type, :wagons, :speed

  def initialize(number:, type:)
    @number = number
    @wagons = []
    @speed = 0
    puts "Train created: #{self}, number: #{self.number}, type: #{self.type}."
  end

  def speed_up
    @speed += 20
    puts "Speed up to: #{@speed}."
  end

  def speed_current
    puts "Current speed: #{self.speed}"
  end

  def speed_stop
    @speed = 0
    puts "Current speed: #{@speed}"
  end

  def wagons_count
    puts "Number of wagons: #{self.wagons.size}"
  end

  def add_wagon(wagon)
    if @speed == 0
      if wagon.type == self.type
        self.wagons << wagon
        puts "Wagon #{wagon} added."
      else
        puts "Error. Wagon type is wrong."
      end
    else
      puts "Stop train."
    end
  end

  def delete_wagon(wagon)
    if speed.zero?
      if self.wagons.delete(wagon)
        puts "Wagon #{wagon} removed."
      else
        puts "There is nothing to unhook."
      end
    else
      puts "Stop train."
    end
  end

  def get_route(route) #take_route
    @route = route
    self.current_station_index = 0
    self.route.stations.first.add_train(self)
    puts "Route #{route.stations.first.title}---#{route.stations.last.title} taken."
  end

  protected

  # Тут методы которые не нужны для пользования извне программы. Это реализация инкапсуляции.
  # Методы внесены в protected для того, что бы следуя "соглашению" дать к ним доступ из дочерних классов

  def current_station
    self.route.stations[current_station_index]
  end

  def next_station
    if self.current_station_index == self.route.stations.size - 1
      puts "Error. #{current_station.title} is the ending station."
    else
      current_station.send_train(self)
      self.current_station_index += 1
      current_station.add_train(self)
      puts "Train #{self.number} moved to station #{current_station.title}."
    end
  end

  def previous_station
    if self.current_station_index == 0
      puts "Error. #{current_station.title} is the ending station."
    else
      current_station.send_train(self)
      self.current_station_index -= 1
      current_station.add_train(self)
      puts "Train #{self.number} moved to station #{current_station.title}."
    end
  end

  def passenger?
    self.type == :pass
  end

  def cargo?
    self.type == :cargo
  end
end