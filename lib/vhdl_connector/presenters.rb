require 'forwardable'

module VhdlConnector::Presenters
  class EntityPresenter
    extend Forwardable
    def_instance_delegators :@entity,
      :name, :generics, :ports, :local_name
    def initialize(entity_wrapper)
      @entity = entity_wrapper
    end
  end
end

require_relative 'presenters/component_definition_presenter'
require_relative 'presenters/component_mapping_presenter'
require_relative 'presenters/connector_presenter'
require_relative 'presenters/signal_definition_presenter'

