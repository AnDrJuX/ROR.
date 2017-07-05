require_relative "module"
require_relative "instance_counter"

class Train

  include CompanyTitle
  include InstanceCounter

  @@instances = 0
  @@trains = {}

  attr_reader :current_speed, :wagons, :current_station, :current_route, :num, :type

  NUM_FORMAT =  /\A[a-z0-9]{3}-*[a-z0-9]{2}\z/i

  def initialize(num, type)
    @num = num
    @type = type
    @current_speed = 0
    @wagons = []
    @@num = num
    validate!
    @@trains[num] = self
    register_instance
  end

  def valid?
    self.validate!
  rescue
    false
  end

  def self.find(num)
    @@trains[num]
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
    if current_speed == 0
      @wagons << wagon
      puts "Вагон добавлен."
    else
      puts "Для добавления вагона остановите поезд."
    end
  end

  def unhook(wagon)
    if current_speed == 0 && wagons.size > 0
      @wagons.delete(wagon)
      puts "Вагон отцеплен."
    end
  end

  def move_back
    if current_station != current_route.route.first
      ind = current_route.route.index current_station
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

  protected

  def validate!
    raise "Number has invalid format" if num !~ NUM_FORMAT
    raise "Type is not valid!" unless type == :passenger || type == :cargo
    true
  end

end

