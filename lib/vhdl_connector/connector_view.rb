require 'erb'

module VhdlConnector
  class ConnectorView < View
    def initialize(template_path, presenter, reader = ConnectorReader.new)
      @template_path = template_path
      @presenter = presenter
      @reader = reader
    end

    def template
      mk_template(@reader.read(File.read(@template_path)).body)
    end
  end
end
