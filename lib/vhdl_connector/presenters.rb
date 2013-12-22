require 'forwardable'

module VhdlConnector::Presenters
  class EntityPresenter
    extend Forwardable
    def_instance_delegators :@entity,
      :name, :generics, :ports
    def initialize(entity_wrapper)
      @entity = entity_wrapper
    end
  end
end

require_relative 'presenters/component_definition_presenter'
require_relative 'presenters/component_map_presenter'
require_relative 'presenters/connector_presenter'

