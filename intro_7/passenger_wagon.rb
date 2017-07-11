class PassengerWagon #< Wagon

  attr_reader :type, :seat, :peoples, :num
  def initialize(num, seat)
    @num = num
    @type = :passenger
    @seat = seat
    @busy_place = 0
  end

  def add_people
    @busy_place += 1 if !free_seat == 0
  end

  def free_seat
    @seat - @busy_place
  end

  def busy_place
    @seat - (@seat - @busy_place) == @busy_place
  end

end