class Train
  attr_accessor :route, :station
  attr_reader :number, :type, :wagons, :current_station_index, :speed

  def initialize(number:, type:)
    @number = number
    @wagons = []
    @type = type
    @speed = 0
    @route = route
    @current_station_index = current_station_index
  end

  def speed(speed)
    self.speed += speed
  end

  def speed_current
    puts "Current speed: #{self.speed}"
  end

  def speed_down
    self.speed = 0
  end

  def wagons_count
    puts "Number of wagons: #{self.wagons.size}"
  end

  def add_wagons
    if @speed == 0
      self.wagons += 1
      puts "Number of wagons: #{self.wagons.size}"
    else
      puts "Stop train."
    end
  end

  def delete_wagons
    if self.wagons.size == 0
      puts "There is nothing to unhook."
    elsif @speed == 0
      self.wagons -= 1
      puts "Number of wagons: #{self.wagons.size}"
    end
  end

  def get_route(route)
    self.route = route
    self.current_station_index = 0
    current_station.add_train(self)
    puts "The train is assigned the route."
  end

  def move_next_station
    if @current_station_index == @route.stations.length - 1
      puts "Train at the last station."
    else
      @current_station.go_and_delete(self)
      @current_station = next_station
      @current_station_index += 1
      @current_station.add_train(self)
      puts "The train went to the next station #{current_station.name}"
    end
  end

  def move_previous_station
    if @current_station_index > 0
      puts "Train at the first station."
    else
      @current_station.go_and_delete(self)
      @current_station = previous_station
      @current_station_index -= 1
      @current_station.add_train(self)
      puts "The train went to the previous station #{current_station.name}"
    end
  end

  def show_stations
    puts "The train is at station #{current_station.name}"
    puts "Behind the station there was a station #{previous_station.name}" if @current_station_index > 0
    puts "Next station #{next_station.name}." if @current_station_index < @route.stations.length - 1
  end

  protected

  # Тут методы которые не нужны для пользования извне программы. Это реализация инкапсуляции.
  # Методы внесены в protected для того, что бы следуя "соглашению" дать к ним доступ из дочерних классов

  def current_station
    @current_station = self.route.stations[self.current_station_index]
  end

  def next_station
    @next_station = self.route.stations[self.current_station_index.next]
    puts "Train #{self.number} moved to station #{current_station_index.next}."
  end

  def previous_station
    @previous_station = self.route.stations[self.current_station_index.pred]
    puts "Train #{self.number} moved to station #{current_station_index.pred}."
  end

  protected

  # Тут методы которые не нужны для пользования извне программы. Это реализация инкапсуляции.
  # Методы внесены в protected для того, что бы следуя "соглашению" дать к ним доступ из дочерних классов

  def current_station
    @current_station = @route.stations[@current_station_index]
  end

  def next_station
    @next_station = @route.stations[@current_station_index.next]
  end

  def previous_station
    @previous_station = @route.stations[@current_station_index.pred]
  end
end