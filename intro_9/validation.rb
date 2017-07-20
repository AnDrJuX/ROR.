
# Написать модуль Validation, который: Содержит метод класса validate.
# Этот метод принимает в качестве параметров имя проверяемого атрибута,
# а также тип валидации и при необходимости дополнительные параметры.
# Возможные типы валидаций: presence - требует, чтобы значение атрибута
# было не nil и не пустой строкой. Пример использования: validate :name, :presence
# format (при этом отдельным параметром задается регулярное выражение для формата).
# Треубет соответствия значения атрибута заданному регулярному выражению. Пример:
# validate :number, :format, /A-Z{0,3}/ type (третий параметр - класс атрибута).
# Требует соответствия значения атрибута заданному классу. Пример: validate :station, :type, RailwayStation
# Содержит инстанс-метод validate!, который запускает все проверки (валидации),
# указанные в классе через метод класса validate. В случае ошибки валидации выбрасывает
# исключение с сообщением о том, какая именно валидация не прошла
# Содержит инстанс-метод valid? который возвращает true, если все проверки валидации
# прошли успешно и false, если есть ошибки валидации.
# К любому атрибуту можно применить несколько разных валидаторов, например
# validate :name, :presence validate :name, :format, /A-Z/ validate :name, :type, String
# Все указанные валидаторы должны применяться к атрибуту
# Допустимо, что модуль не будет работать с наследниками.
# Подключить эти модули в свои классы и продемонстрировать их использование.
# Валидации заменить на методы из модуля Validation.


module Validate
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :types
    def validate(name, type_method, *args)
      @types ||= []
      @types << { name: name, type_method: type_method, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.types.each do |variable|
        value = instance_variable_get("@#{variable[:name]}")
        send variable[:type_method], variable[:name], value, variable[:args]
      end
    end

    def valid?
      validate!
      raise
      false
    end

    def presence(name, check_presence, *args)
      raise "Presence Error" if check_presence.nil? || check_presence.to_s.empty?
    end

    def format(name, format, range)
      raise "Format error" unless range.to_s.match(range)
    end

    def type(name, type, type_class)
      raise "Class Error" unless type.kind_of?(type_class[0])
    end
  end
end
