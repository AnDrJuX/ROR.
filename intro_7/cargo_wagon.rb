class CargoWagon #< Wagon

  attr_reader :type, :volume, :something, :num
  def initialize(num, volume)
    @num = num
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def load_a_wagon(vol)
    @occupied_volume += vol if !free_volume == 0
  end

  def free_volume
    @volume - @occupied_volume
  end

  def occupied_volume
    @volume - (@volume - @occupied_volume) == @occupied_volume
  end

end

