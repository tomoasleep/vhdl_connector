module VhdlConnector::Presenters
  class ComponentMappingPresenter < EntityPresenter
    alias :original_local_name :local_name
    def initialize(entity, options)
      aliases = options[:as] if options && (options.is_a? Hash)
      @aliases = aliases || {}
      @entity = entity
    end

    def generic_mappings
      generics.map { |g| g.mapping }.join(",\n")
    end

    def port_mappings
      ports.map { |pt| "#{pt.name} => #{signal_name(pt)}" }.join(",\n")
    end

    def local_name
      original_local_name || "#{name}_comp"
    end

    def mapping_name_prefix
      original_local_name || name
    end

    private
    def signal_name(port)
      (as = @aliases[port.name.to_sym]) ? as.to_s : "#{mapping_name_prefix}_#{port.name}"
    end
  end
end

