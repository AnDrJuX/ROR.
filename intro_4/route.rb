class Route
  attr_accessor :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station_to_list(station)
    self.stations.insert(-2, station)
  end

  def delete_station_to_list(station)
    self.stations.delete(station)
  end

  def station_list
    self.stations.each do |station|
      puts station.name
    end
  end
end