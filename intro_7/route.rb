class Route
  attr_accessor :route

  def initialize(from, to)
    @route = [from, to]
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end


  def add_station(station)
    @route.insert(-2, station)
  end

  def del_station(station)
    if @route.include? station
      @route.delete(station)
    else
      raise "Станции #{station} нет в маршруте!"
    end
  end

  def get_station_list
    @route.each { |e| puts e }
  end

  protected

  def validate!
    raise "Passed arguments is not objects of class Station!" if !self.route.first.is_a?(Station) || !self.route.last.is_a?(Station)

    true
  end
end