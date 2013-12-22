module VhdlConnector::Presenters
  class ConnectorPresenter
    include VhdlConnector::Helper
    attr_writer :cwd
    def initialize(entities: [], packages: [], cwd: nil)
      @dependency_entities = entities
      @dependency_packages = packages
      @cwd = cwd
    end

    def cwd
      @cwd || './'
    end

    def use_entity(*pathes)
      @dependency_entities += pathes
        .map { |path| File.expand_path(path, cwd) }
        .map { |abs_path| parse_entity_file(abs_path) }
    end

    def header(*options)
      @dependency_entities.map { |entity| entity.to_component_definition }
    end

    def mapping(*options)
      @dependency_entities.map { |entity| entity.to_component_mapping }
    end
  end
end
