module VhdlConnector::Presenters
  class ComponentMappingPresenter < EntityPresenter
    alias :original_local_name :local_name
    def generic_mappings
      generics.map { |g| g.mapping }.join(",\n")
    end

    def port_mappings
      ports.map { |pt| "#{pt.name} => #{mapping_name_prefix}_#{pt.name}" }.join(",\n")
    end

    def local_name
      original_local_name || "#{name}_comp"
    end

    def mapping_name_prefix
      original_local_name || name
    end

  end
end

