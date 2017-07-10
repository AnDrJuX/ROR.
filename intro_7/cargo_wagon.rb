class CargoWagon #< Wagon

  attr_reader :type, :volume, :something, :num
  def initialize(num, volume)
    @num = num
    @type = :cargo
    @volume = volume
    @something = 0
  end

  def load_a_wagon(vol)
    @something += vol unless free_volume == 0
  end

  def free_volume
    @volume - @something
  end

  def occupied_volume
    @volume - free_volume
  end

end