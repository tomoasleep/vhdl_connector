module VhdlConnector::Presenters
  class SignalDefinitionPresenter < EntityPresenter
    alias :original_local_name :local_name
    def port_definitions
      ports.map { |pt| port_definition(pt) }.join("\n")
    end

    def port_definition(port)
      "signal #{mapping_name_prefix}_#{port.name} : #{port.type_description};"
    end

    def local_name
      original_local_name || "#{name}_comp"
    end

    def mapping_name_prefix
      original_local_name || name
    end

  end
end

