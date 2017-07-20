require_relative 'validation'

class Route
  include Validate

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

  def station_list
    @route.each { |e| puts e }
  end

  protected

  def validate!
    if !route.first.is_a?(Station) || !route.last.is_a?(Station)
      raise 'Passed arguments is not objects of class Station!'
    end
    true
  end
end
