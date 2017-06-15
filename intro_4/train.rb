class Train

  attr_reader :current_speed, :wagons, :current_station, :current_route, :num, :type

  def initialize(num, type)
    @num = num
    @type = type
    @current_speed = 0
    @wagons = []
  end

  def take_route(route)
    @current_route = route
    @current_station = current_route.route.first
  end

  def speed_up
    @current_speed += 10
  end

  def brake
    @current_speed = 0
  end

  def hook(wagon)
    if wagon.type == @type
      @wagons << wagon
    else
      puts "Ошибка типа вагона!"
    end

  end

  def unhook(wagon)
    if current_speed == 0 && wagons.size > 0
      @wagons.delete(wagon)
    end
  end

  def move_back
    if current_station != current_route.route.first
      ind = current_route.index current_station
      @current_station = current_route.route[ind - 1]
    else
      puts "Станция #{@current_station} является отправной. Поезд не может двигаться назад"
    end
  end

  def move_forward
    if current_station != current_route.route.last
      ind = current_route.route.index current_station
      @current_station = current_route.route[ind + 1]
    else
      puts "Станция #{@current_station} является конечной. Поезд не может двигаться вперед"
    end
  end
end