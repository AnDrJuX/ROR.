require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'

# puts 'Добро пожаловать на железнодорожную станцию!'
# puts 'Введите номер действия, которое вы хотите совершить.'
# puts '1 - Создать станцию'
# puts '2 - Создать поезд'
# puts '3 - Создавать маршрут'
# puts '4 - Добавить станцию к маршруту'
# puts '5 - Удалить станцию маршрута'
# puts '6 - Назначить маршрут поезду'
# puts '7 - Добавить вагон к поезду'
# puts '8 - Отцепить вагон от поезда'
# puts '9 - Переместить поезд по маршруту вперед'
# puts '10 - Переместить поезд по маршруту назад'
# puts '11 - Просматривать список станций'
# puts '12 - Просматривать список поездов на станции'

action = gets.chomp.to_i

case action
  when 1
    puts 'Создать станцию'
  when 2
    puts 'Создать поезд'
  when 3
    puts 'Создать маршрут'
  when 4
    puts 'Добавить станцию к маршруту'
  when 5
    puts 'Удалить станцию маршрута'
  when 6
    puts 'Назначить маршрут поезду'
  when 7
    puts 'Добавить вагон к поезду'
  when 8
    puts 'Отцепить вагон от поезда'
  when 9
    puts 'Переместить поезд по маршруту вперед'
  when 10
    puts 'Переместить поезд по маршруту назад'
  when 11
    puts 'Просматривать список станций'
  when 12
    puts 'Просматривать список поездов на станции'
  else
    puts 'Нет такого действия.'
end

station01 = Station.new('station01')
station02 = Station.new('station02')
route01 = Route.new(station01, station02)
train01 = PassengerTrain.new(01)
train02 = CargoTrain.new(02)
train01.get_route(route01)
train01.show_stations
train01.move_next_station
passwag = PassengerWagon.new
cargwag = CargoWagon.new
train02.uncoupling(passwag)