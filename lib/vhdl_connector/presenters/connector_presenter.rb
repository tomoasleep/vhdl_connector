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
          name_map = (value.is_a? Hash) ? value : { new_entities.first.name => value }
          @aliases.merge! name_map.symbolize_keys
        end
      end

      @dependency_entities
        .map { |entity| resolve_aliases(entity) }
        .flatten
    end

    def component_definitions(*options)
      VhdlConnector::BlockDecorator.decorate_component_definition_block(
        component_definitions_obj(*options).join("\n")
      )
    end

    def component_signal_definitions(options = {})
      VhdlConnector::BlockDecorator.decorate_signal_block(
        component_signal_definitions_obj(options).join("\n")
      )
    end

    def define_component_mappings(options = {})
      @mapping_options = options
    end

    def component_mappings(options = {})
      options = (@mapping_options || {}).merge options
      VhdlConnector::BlockDecorator.decorate_component_mapping_block(
        mapping_obj(options).join("\n")
      )
    end

    alias mapping component_mappings

    def component_definitions_obj(*options)
      @dependency_entities.map { |entity| entity.to_component_definition }
    end

    def component_signal_definitions_obj(options = {})
      components.map { |entity| entity.to_component_signal_definition(options) }
    end

    def mapping_obj(options = {})
      components.map { |entity| entity.to_component_mapping(options) }
    end

    private
    def resolve_aliases(entity)
      aliases_key = @aliases[entity.name.to_sym]
      return entity unless aliases_key

      aliases = (aliases_key.is_a? Array) ? aliases_key : [aliases_key]
      aliases.map { |name| VhdlConnector::EntityWrapper.new(entity.entity, local_name: name.to_s) }
    end
  end
end
