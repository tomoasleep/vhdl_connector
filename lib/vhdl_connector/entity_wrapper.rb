require 'forwardable'

module VhdlConnector
  class EntityWrapper
    extend Forwardable
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

    def to_component
      View.new(
        template_path('component.vhd.erb'),
        Presenters::ComponentDefinitionPresenter.new(self)
      ).run
    end

    def to_component_map
      View.new(
        template_path('component_map.vhd.erb'),
        Presenters::ComponentMapPresenter.new(self)
      ).run
    end
  end
end
