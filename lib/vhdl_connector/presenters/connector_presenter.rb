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

    def components(*args)
      pathes = args_without_options(args)
      options = options_of_args(args)

      new_entities = pathes
        .map { |path| File.expand_path(path, cwd) }
        .map { |abs_path| VhdlConnector.parse_entity_file(abs_path) }
      @dependency_entities += new_entities

      @aliases ||= {}
      options.map do |key, value|
        case key.to_sym
        when :as
          name_map = value.is_a? Hash ? value : { new_entities.first.name => value }
          @aliases.merge name_map.symbolize_keys
        end
      end

      @dependency_entities
        .map { |entity| resolve_aliases(entity) }
        .flatten
    end

    def header(*options)
      header_obj(*options).join('\n')
    end

    def mapping(*options)
      mapping_obj(*options).join('\n')
    end

    def header_obj(*options)
      @dependency_entities.map { |entity| entity.to_component_definition }
    end

    def mapping_obj(*options)
      components.map { |entity| entity.to_component_mapping }
    end

    private
    def resolve_aliases(entity)
      names = @aliases[entity.name.to_sym]
      return entity unless names

      case names
      when Array
        names.map { |name| EntityWrapper.new(entity.entity, local_name: name.to_s) }
      else
      end
    end
  end
end
