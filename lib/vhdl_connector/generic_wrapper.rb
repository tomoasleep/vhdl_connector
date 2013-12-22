
require 'forwardable'

module VhdlConnector
  class GenericWrapper
    extend Forwardable
    def_instance_delegators :@generic,
      :name, :direction, :type,
      :value, :left, :right, :size_dir

    def initialize(generic)
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
      "#{type}#{range_description}"
    end

    def range_description
      "(#{left} #{size_dir} #{right})" if size_dir
    end

    def default_value_description
      ":= #{value}" if value
    end
  end
end
