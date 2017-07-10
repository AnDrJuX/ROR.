require_relative "train"
require_relative "station"
require_relative "route"
require_relative "passenger_wagon"
require_relative "cargo_wagon"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "module"
require_relative "instance_counter"

class Main
  attr_reader :routes, :trains, :stations, :wagons

  def initialize
    @routes = []
    @trains = []
    @stations = []
    @wagons =[]
  end

  def create_station
    puts "Введите станцию:"
    title = gets.chomp
    station = Station.new(title)
    self.stations << station
    puts "Создана станция #{station.title}"
  end

  def stations_list
    @stations.each_with_index do |station, index|
      puts "#{index}. #{station.title}.#{station} "
    end
  end

  def create_train
    num_format = /\A[a-zа-я0-9]{3}-*[a-zа-я0-9]{2}\z/i
    begin
      puts "Введите номер поезда"
      num = gets.chomp
      raise if num !~ num_format
    rescue
      puts "Номер поезда не соответствует формату! Попробуйте еще раз"
      retry
    end

    begin
      puts "Выберите тип создаваемого поезда: 1. Пассажирский, 2. Грузовой"
      type = gets.chomp.to_i
      raise if type < 1 || type > 2
    rescue
      puts "Введено неправильное значение! введите 1 или 2 "
      retry
    end

    if type == 1
      train = PassengerTrain.new(num)
    elsif type == 2
      train = CargoTrain.new(num)
    end

    begin
      puts "Введите количество вагонов."
      w_count = gets.chomp.to_i
      raise if w_count < 0 || w_count > 50
    rescue
      puts "Количество вагонов привышено! Попробуйте еще раз"
      retry
    end

    self.trains << train
    puts "Создан поезд: #{num}, #{train.type}, вагонов: #{w_count}."

  end

  def create_new_route
    puts "Выберите станцию отправления:"
    from = select_station
    puts "Выберите станцию прибытия:"
    to = select_station
    new_route = Route.new(from, to)
    puts "Маршрут #{from} - #{to} создан успешно"
    self.routes << new_route
  end

  def add_station_to_route
    puts "Выберите станцию из списка: "
    station = select_station
    puts "Выберите маршрут из списка: "
    route = select_route
    route.add_station(station)
    puts "Станция #{station} добавлена в маршрут #{route} "
  end

  def add_train_to_station
    puts "Выберите поезд из спиака: "
    train = select_train
    puts "Выберите станцию из списка: "
    station = select_station
    station.add_train(train)
    puts "Поезд #{train} добавлен на станцию #{station} "
  end

  def remove_station
    puts "Выберите маршрут из списка: "
    route = select_route
    puts "Какую станцию из маршрута хотите удалить? "
    id = select_station
    route.del_station(id)
    puts "Станция #{id} удалена."
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
    puts "Выберите поезд."
    train = select_train
    puts "Выберите станцию."
    route = select_route
    train.take_route(route)
    puts "Поезду #{train.num} добавлен маршрут."
  end


  def add_wagon
    puts "Выберите поезд из списка: "
    train = select_train
    puts "Выберите тип вагона:
    1. Пассажирский,
    2. Грузовой"
    type = gets.chomp.to_i
    puts "Укажите номер вагона: "
    num = gets.chomp
    if type == 1
      puts "Введите количество мест в вагоне: "
      seat = gets.chomp.to_i
      wagon = PassengerWagon.new(num, seat)
    elsif type == 2
      puts "Введите объём вагона: "
      volume = gets.chomp
      wagon = CargoWagon.new(num, volume)
    else
      puts "Ошибка!!!"
    end
    train.hook(wagon)
    puts train.wagons

  end

  def delete_wagon
    puts "Выберите поезд из спиака: "
    train = select_train
    puts "Выберите вагон из спиака: "
    wagon = select_wagon
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

  def stations_train_list
    station = select_station
    puts "Список поездов на станции: "
    station.method_trains { |train| puts "Номер: #{train.num}, тип: #{train.type}, вагонов: #{train.wagons.size}" }
  end

  def train_wagon_list
    puts "Выберите поезд из спиака: "
    train = select_train
    puts "Список вагонов поезда: "
    train.wagon_list do |wagon|
      if wagon.type == :passenger
        puts "Номер: #{wagon.num}, тип: #{wagon.type}, занято: #{wagon.busy_place}, свободно #{wagon.free_seat}"
      elsif  wagon.type == :cargo
        puts "Номер: #{wagon.num}, тип: #{wagon.type}, занято: #{wagon.occupied_volume }, свободно #{wagon.free_volume}"
      end
    end
  end


  protected # нижеследующие методы класса необходимы лишь внутри объекта класса

  attr_writer :routes, :trains, :stations

  def select_route
    routes.each_with_index {|r, id| puts "#{id}.#{r}"}
    route = gets.chomp.to_i
    routes[route]
  end

  def select_station
    stations.each_with_index {|s, id| puts "#{id}. #{s.title}" }
    index_station = gets.chomp.to_i
    stations[index_station]
  end

  def select_train
    trains.each_with_index {|train, id |puts "#{id}. #{train.num},  #{train.type}"}
    id = gets.chomp.to_i
    trains[id]
  end

  def select_wagon
    wagons.each_with_index {|wagon, id| puts "#{id}. #{wagon.num}"}
    index_wa = gets.chomp.to_i
    wagons[index_wa]
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
  8. Показать список поездов на станции
  9. Показать список вагонов у поезда
  10. Список станций.
  0. ВЫХОД ИЗ ПРОГРАММЫ"

  begin

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
        main.stations_train_list
      when 9
        main.train_wagon_list
      when 10
        main.stations_list
      when 10
        main.add_train_to_station
      else
        puts "Попробуйте еще раз."
    end
  rescue StandardError => e
    puts e.message
  end

end