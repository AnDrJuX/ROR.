class Wagon
  include CompanyTitle
  include InstanceCounter

  def initialize
    register_instance

  end
end