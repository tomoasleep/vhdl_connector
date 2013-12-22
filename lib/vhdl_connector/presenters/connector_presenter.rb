module VhdlConnector::Presenters
  class ConnectorPresenter
    include VhdlConnector::Helper
    def set_cwd(path)
      @cwd = path
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
