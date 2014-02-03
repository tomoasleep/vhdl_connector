module VhdlConnector
  class ConnectorReader
    attr_reader :body

    def read(code)
      @body = BlockDecorator.undecorate_code(code)
      self
    end
  end
end
