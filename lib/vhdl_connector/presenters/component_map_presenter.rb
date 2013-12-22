module VhdlConnector::Presenters
  class ComponentMapPresenter < EntityPresenter
    def generic_mappings
      generics.map { |g| g.mapping }.join(',\n')
    end

    def port_mappings
      ports.map { |pt| "#{pt.name} => #{name}_#{pt.name}" }.join(',\n')
    end
  end
end

