require 'forwardable'

module VhdlConnector
  class EntityWrapper
    extend Forwardable
    include Helper

    def_instance_delegators :@entity, :name

    def initialize(entity)
      @entity = entity
    end

    def generics
      @generics ||= @entity.generics.map { |g| GenericWrapper.new(g) }
    end

    def ports
      @ports ||= @entity.ports.map { |g| PortWrapper.new(g) }
    end

    def to_component_definition
      View.new(
        template_path('component_definition.vhd.erb'),
        Presenters::ComponentDefinitionPresenter.new(self)
      ).run
    end

    def to_component_mapping
      View.new(
        template_path('component_mapping.vhd.erb'),
        Presenters::ComponentMappingPresenter.new(self)
      ).run
    end
  end
end
