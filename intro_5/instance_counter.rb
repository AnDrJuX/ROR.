module InstanceCounter
  attr_accessor :instances

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end

    def count
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods

    def print_class
      puts self.class
    end

    protected

    def register_instance
      self.class.send :count
    end
  end
end