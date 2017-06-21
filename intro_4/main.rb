require_relative "train"
require_relative "station"
require_relative "route"
require_relative "passenger_wagon"
require_relative "cargo_wagon"
require_relative "cargo_train"
require_relative "passenger_train"

class Main
  attr_reader :routes, :trains, :stations

  def initialize
    @routes   = []
    @trains   = []
    @stations = []
  end

  def create_station
    puts "Ведите станцию:"
    station = gets.chomp
    station = Station.new(station)
    self.stations << station
    puts "Создана станция #{station}"
  end

  def create_train
    puts "Введите номер поезда"
    num = gets.chomp
    puts "Выберите тип создаваемого поезда: 1. Пассажирский, 2. Грузовой"
    type = gets.chomp.to_i
    if type == 1
      train = PassengerTrain.new(num)
    elsif type == 2
      train = CargoTrain.new(num)
    else
      puts "Попробуйте еще раз."
    end
    self.trains << train
    puts "Создан поезд: #{num}, #{type}."
  end

  def create_new_route
    @stations.each { |station| puts " #{station.title} " }
    puts "Введите станцию отправления:"
    from = gets.chomp
    from_station = @stations.select { |station| station.title == from }
    @stations.each { |station| puts " #{station.title} " }
    puts "Введите станцию прибытия:"
    to = gets.chomp
    to_station = @stations.select { |station| station.title == to }
    new_route = Route.new(from_station, to_station)
    puts "Маршрут #{from_station} - #{to_station} создан успешно"
    self.routes << new_route
  end

  def add_station_to_route
    @stations.each { |station| puts " #{station.title} " }
    puts "Выберите станцию из списка: "
    station = gets.chomp
    station_to_route = @stations.select { |station_to| station_to.title == station }
    @routes.each_with_index { |route, id| puts "#{id + 1} #{route}" }
    puts "Выберите маршрут из списка: "
    route = gets.chomp.to_i
    route_to_add_station = @routes.select { |route_to| route_to == route }
    route_to_add_station.add_station(station_to_route)
    puts "Станция #{station_to_route} добавлена в маршрут #{route_to_add_station} "
  end

  #Ты опять сравниваешь объекты из routes с тем, что ввел пользователь. Строка - это не объект

  # Метод add_station_to_route:
  # Нужно добавлять объекты станций в объект маршрута
  # для этого по введенному названию станции надо найти ее объект
  # затем по выбранному номеру маршрута найти объект маршрута
  # и вызывав у объекта маршрута метод add_station добавить объект станции к нему

  def remove_station
    route = select_route
    puts "Какую станцию из маршрута хотите удалить? (введите название): "
    route.del_station(gets.chomp)
    puts "Станция #{route} удалена."
  end

  def edit_route
    puts "Выберите действие с маршрутом:
    1 - Создать новый маршрут
    2 - добавить станцию в маршрут
    3 - удалить станцию из маршрута
    0 - выйти в главное меню"

    choise = gets.chomp.to_i
    case choise
      when 1
        create_new_route
      when 2
        add_station_to_route
      when 3
        remove_station
      when 0
        Exit
    end
  end

  def direct_route
    if trains.size == 0
      puts "список поездов пуст, создайте сперва поезда"
    else
      train = select_train
    end
    if routes.size == 0
      puts "список маршрутов пуст, создайте сперва маршруты"
    else
      route = select_route
    end
    train.take_route(route)
    puts "Поезду #{train}добавлен маршрут#{route}."
  end

  def add_wagon
    train = select_train
    puts "Выберите тип вагона: 1. Пассажирский, 2. Грузовой"
    type = gets.chomp.to_i
    if type == 1
      new_wagon = PassengerWagon.new
    elsif type == 2
      new_wagon = CargoWagon.new
    else
      puts "Ошибка!!!"
    end
    train.hook(new_wagon)
    puts train.wagons
  end

  def delete_wagon
    train = select_train
    wagon = select_wagon(train)
    train.unhook(wagon)
    puts train.wagons
  end

  def move_train
    train = select_train
    if !train.current_route
      puts "Поезду не назначен маршрут. Сначала назначьте"
    else
      puts "Выберите направление движения поезда: 1. Вперед, 2. Назад"
      choise = gets.chomp.to_i
      if choise == 1
        train.move_forward
      elsif choise == 2
        train.move_back
      else
        puts "Ошибка!!!"
      end
      puts "Текущая станция #{train.current_station}"
    end
  end

  def list_stations_trains
    puts "Список станций: "
    stations.each { |station| puts station.title }
    puts "Список поездов: "
    trains.each do |train|
      puts "Номер поезда: #{train.num} Тип: #{train.type}"
    end
  end

  protected # нижеследующие методы класса необходимы лишь внутри объекта класса

  attr_writer :routes, :trains, :stations

  def select_route
    puts "Выберите маршрут из списка:"
    routes.each_index { |r| puts "#{r} - #{routes[r].route.to_s}" }
    index_route = gets.chomp.to_i
    routes[index_route]
  end

  def select_train
    puts "Выберите поезд из списка:"
    trains.each_index { |t| puts "#{t} . #{trains[t].num} - #{trains[t].type}" }
    index_train = gets.chomp.to_i
    trains[index_train]
  end

  def select_wagon(train)
    puts "Выберите вагон из состава:"
    train.wagons.each_index { |i| puts "#{i} - #{train.wagons[i]}" }
    index_wagon = gets.chomp.to_i
    train.wagons[index_wagon]
  end
end

main = Main.new
loop do
  puts " Выберите действие:
  1. Создать станцию
  2. Создать поезд
  3. Создать маршрут или управлять станциями в нем (добавлять, удалять)
  4. Назначить маршрут поезду
  5. Добавить вагоны к поезду
  6. Отцепить вагоны от поезда
  7. Переместить поезд по маршруту вперед и назад
  8. Вывести список станций и список поездов на станции
  0. ВЫХОД ИЗ ПРОГРАММЫ"

  choise = gets.chomp.to_i

  break if choise == 0
  case choise
    when 1
      main.create_station
    when 2
      main.create_train
    when 3
      main.edit_route
    when 4
      main.direct_route
    when 5
      main.add_wagon
    when 6
      main.delete_wagon
    when 7
      main.move_train
    when 8
      main.list_stations_trains
    else
      puts "Попробуйте еще раз."
  end
end