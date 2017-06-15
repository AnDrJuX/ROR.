require_relative "train"
require_relative "station"
require_relative "route"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

class Main
  attr_reader :routes, :trains, :stations

  def initialize
    @routes = []
    @trains = []
    @stations = []
  end

  def create_station
    puts "Ведите название станции"
    title = gets.chomp
    station = Station.new(title)
    self.stations << station
    puts "Создана станция #{title}"
  end

  def create_train
    puts "Введите номер поезда"
    num = gets.chomp
    puts "Выберите тип создаваемого поезда: intro_4. Пассажирский, 2. Грузовой"
    type = gets.chomp.to_i
    if type == 1
      train = Train.new(num, :passenger)
    elsif type == 2
      train = Train.new(num, :cargo)
    else
      puts "Попробуйте еще раз."
    end
    self.trains << train
    puts "Сщздан поезд: #{num}."
  end

  def create_new_route
    puts "Введите название первой станции:"
    from = gets.chomp
    puts "Введите название последней станции:"
    to = gets.chomp
    route = Route.new(from, to)
    puts "Маршрут #{from} - #{to} создан успешно"
    self.routes << route
  end

  def add_station_to_route
    route = select_route
    puts "Введите название добавляемой станции в маршрут: "
    route.add_station(gets.chomp)
    puts "Станция #{route} добавлена в маршрут."
  end

  def remove_station
    route = select_route
    puts "Какую станцию из маршрута хотите удалить? (введите название): "
    route.del_station(gets.chomp)
    puts "Станция #{route} удалена."
  end

  def edit_route
    puts "Выберите действие с маршрутом:
    intro_4 - Создать новый маршрут
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
    puts "Выберите тип вагона: intro_4. Пассажирский, 2. Грузовой"
    type = gets.chomp.to_i
    if type == 1
      wagon = PassengerWagon.new
    elsif type == 2
      wagon = CargoWagon.new
    else
      puts "Ошибка!!!"
    end
    train.hook(wagon)
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
    if train.current_route == nil
      puts "Поезду не назначен маршрут. Сначала назначьте"
    else
      puts "Выберите направление движения поезда: intro_4. Вперед, 2. Назад"
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
      puts "Номер поезда: #{train.num_tr} Тип: #{train.type}"
    end
  end

  protected  # нижеследующие методы класса необходимы лишь внутри объекта класса

  attr_writer :routes, :trains, :stations

  def select_route
    puts "Выберите маршрут из списка:"
    routes.each_index { |r| puts "#{r} - #{routes[r].route.to_s}" }
    index_route = gets.chomp.to_i
    routes[index_route]
  end

  def select_train
    puts "Выберите поезд из списка:"
    trains.each_index { |t| puts "#{t} - #{trains[t].num} - #{trains[t].type}" }
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
  intro_4. Создать станцию
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