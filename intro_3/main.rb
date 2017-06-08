require_relative '../../train_station/station'
require_relative '../../train_station/train'


station_1 = Station.new(name: "Tallinn")
station_2 = Station.new(name: "Vilnius")
station_3 = Station.new(name: "Riga")


route_1 = Route.new(first: station_1, last: station_2)

train1 = Train.new("1", "cargo",  20)
train2 = Train.new("2", "passenger", 10)
train3 = Train.new("3", "cargo", 56)

