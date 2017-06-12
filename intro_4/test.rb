puts "===== Start testing ====="

st1 = Station.new(title: "Tallinn")
st2 = Station.new(title: "Saint-Petersburg")
st3 = Station.new(title: "Riga")
st4 = Station.new(title: "Vilnius")
st5 = Station.new(title: "Gomel")

puts "========================="

route1 = Route.new(start: st1, finish: st2)

puts "========================="

route1.add_station(st3)
route1.add_station(st4)
route1.show_all_stations

puts "========================="

route1.delete_station(st3)
route1.show_all_stations

puts "========================="

train1 = PassengerTrain.new(number: 7, type: :pass)
train2 = PassengerTrain.new(number: 12, type: :pass)
train3 = CargoTrain.new(number: 43, type: :cargo)

puts "========================="

st5.add_train(train1)
st5.add_train(train2)
st5.add_train(train3)
st5.show_all_trains
st5.type_list(:pass)

puts "========================="

st5.send_train(train3)
st5.show_all_trains

puts "========================="

wagon1 = CargoWagon.new
wagon2 = CargoWagon.new
wagon3 = CargoWagon.new

puts "========================="

train4 = CargoTrain.new(number: 6, type: :cargo)
train4.speed_up
train4.speed_up
train4.speed_up
puts "Current speed: #{train4.speed}"
train4.speed_stop
puts "Wagons: #{train4.wagons}"
train4.add_wagon(wagon1)
train4.speed_stop
train4.add_wagon(wagon1)
train4.add_wagon(wagon2)
puts "Wagons: #{train4.wagons}"
train4.delete_wagon(wagon2)
puts "Wagons: #{train4.wagons}"

puts "========================="

route1.add_station(st3)
route1.add_station(st5)
route1.show_all_stations
train4.get_route(route1)
train4.move_next_station
train4.move_next_station
train4.move_back_station
train4.move_back_station
train4.move_back_station

puts "===== Finish testing ====="