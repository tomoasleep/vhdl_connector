
require 'forwardable'

module VhdlConnector
  class GenericWrapper
    def_instance_delegators :@generic,
      :name, :direction, :type, value

    def initialize(entity)
      @generic = generic
    end

    def definition
      "#{name} : #{type_description} #{default_value_description}".strip
    end

    def mapping(value = value)
      "#{name} => #{value}"
    end

    private
    def type_description
      "#{type} #{type_description}"
    end

    def default_value_description
      ":= #{value}" if value
    end
  end
end
