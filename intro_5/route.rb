class Route
  attr_accessor :route
  def initialize(from, to)
    @route = [from, to]
  end

  def add_station(station)
    @route.insert(-2, station)
  end

  def del_station(station)
    if @route.include? station
      @route.delete(station)
    else
      puts "Станции #{station} нет в маршруте!"
    end
  end

  def get_station_list
    @route.each { |e| puts e }
  end

end