class PassengerTrain < Train

  def initialize(number, type = "passenger")
    super
  end

  def hookup(wagon)
    if wagon.instance_of?(PassengerWagon)
      super(wagon)
    else
      puts "To passenger train it is possible to attach only passenger wagons."
    end
  end

end