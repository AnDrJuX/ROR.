class PassengerWagon #< Wagon

  attr_reader :type, :seat, :peoples, :num
  def initialize(num, seat)
    @num = num
    @type = :passenger
    @seat = seat
    @peoples = 0
  end

  def add_people
    @peoples += 1 unless free_seat == 0
  end

  def free_seat
    @seat - @peoples
  end

  def busy_place
    @seat - free_seat
  end

end