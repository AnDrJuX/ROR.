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
    @route.each {|e| puts e}
  end

  protected

  # Тут хорошо бы добавить валидации на то, что переданные аргументы - это объекты класса Station, а не что-то еще.
  # Тебе нужно проверить каждый элемент в массиве на то, что он именно объект класса Station.
  # У объекта можно проверить класс через метод is_a?
  def validate!
    raise "Passed arguments is not objects of class Station!" if !@route.first.is_a?(Station) || !@route.last.is_a?(Station)

    true
  end
end