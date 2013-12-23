module VhdlConnector::Presenters
  class ComponentDefinitionPresenter < EntityPresenter
    def generic_definitions
      generics.map { |g| g.definition }.join(";\n")
    end

    def port_definitions
      ports.map { |pt| pt.definition }.join(";\n")
    end
  end
end
