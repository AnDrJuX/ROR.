class CargoTrain < Train

  def initialize(number, type = "cargo")
    super
  end

  def hookup(wagon)
    if wagon.instance_of?(CargoWagon)
      super(wagon)
    else
      puts "Only cargo wagons can be hooked to the freight train."
    end
  end

end