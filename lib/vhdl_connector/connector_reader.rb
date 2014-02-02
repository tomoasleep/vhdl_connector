module VhdlConnector
  class ConnectorReader
    attr_reader :body

    def read(text)
      body = BlockDecorator.escape_ruby(text)
      body = BlockDecorator.undecorate_component_mapping_block(body)
      body = BlockDecorator.undecorate_component_definition_block(body)
      @body = BlockDecorator.undecorate_signal_definition_block(body)
      self
    end
  end
end
