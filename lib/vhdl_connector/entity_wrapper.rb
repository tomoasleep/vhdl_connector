require 'forwardable'

module VhdlConnector
  class EntityWrapper
    extend Forwardable
    include Helper

    attr_reader :entity, :local_name
    def_instance_delegators :@entity, :name

    def initialize(entity, local_name: nil)
      @entity = entity
      @local_name = local_name
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

    def to_component_signal_definition(options = {})
      View.new(
        template_path('signal_definition.vhd.erb'),
        Presenters::SignalDefinitionPresenter.new(self)
      ).run
    end

    def to_component_mapping(options = {})
      View.new(
        template_path('component_mapping.vhd.erb'),
        Presenters::ComponentMappingPresenter.new(self, options)
      ).run
    end
  end
end
