require 'forwardable'

require_relative 'presenters/component_map_presenter'

module VhdlConnector::Presenters

  class EntityPresenter
    def_instance_delegators :@entity,
      :name, :generics, :ports
    def initialize(entity_wrapper)
      @entity = entity_wrapper
    end
  end
end
