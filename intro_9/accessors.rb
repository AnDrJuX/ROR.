module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name){ instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @history_buffer ||= {}
          @history_buffer[name] ||= []
          @history_buffer[name] << value
        end
        define_method("#{name}_history") {@history_buffer[name]}
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name){ instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise TypeError unless class_name.kind_of?(value)
      instance_variable_set(var_name, value)
    end
  end
end

# Написать модуль Acessors, содержащий следующие методы, которые можно вызывать на уровне класса:
# метод attr_accessor_with_history
# Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов,
# при этом сеттер сохраняет все значения инстанс-переменной при изменении этого значения.
# Также в класс, в который подключается модуль должен добавляться инстанс-метод
# <имя_атрибута>_history который возвращает массив всех значений данной переменной.

# метод strong_attr_acessor
# который принимает имя атрибута и его класс.
# При этом создается геттер и сеттер для одноименной инстанс-переменной,
# но сеттер проверяет тип присваемоего значения. Если тип отличается от того,
# который указан вторым параметром, то выбрасывается исключение.
# Если тип совпадает, то значение присваивается.
# Подключить эти модули в свои классы и продемонстрировать их использование.