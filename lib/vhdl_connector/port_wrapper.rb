require 'forwardable'

module VhdlConnector
  class PortWrapper
    extend Forwardable
    def_instance_delegators :@port,
      :name, :direction, :type,
      :value, :left, :right, :size_dir

    def initialize(port)
      @port = port
    end

    def definition()
      "#{name} : #{direction} #{type_description}".strip
    end

    def type_description
      "#{type}#{range_description}"
    end

    def range_description
      "(#{left} #{size_dir} #{right})" if size_dir
    end
  end
end
