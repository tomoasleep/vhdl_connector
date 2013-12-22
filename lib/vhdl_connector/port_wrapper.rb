require 'forwardable'

module VhdlConnector
  class PortWrapper
    def_instance_delegators :@port,
      :name, :direction, :type

    def initialize(entity)
      @port = port
    end

    def definition
      "#{name} : #{direction} #{type_description}".strip
    end

    private
    def type_description
      "#{type} #{type_description}"
    end
  end
end
