module VhdlConnector
  module BlockDecorator
    extend self
    COMPONENT_MAPPING_LABEL = /COMPONENT\s*MAPPING\s*BLOCK/
    COMPONENT_DEFINITION_LABEL = /COMPONENT\s*DEFINITION\s*BLOCK/
    SIGNAL_LABEL = /SIGNAL\s*BLOCK/

    COMPONENT_DEFINITION_BLOCK =
      /^\s*-{2,}?\s*#{COMPONENT_DEFINITION_LABEL}\s*BEGIN(.*?)#{COMPONENT_DEFINITION_LABEL}\s*END.*?$/m
    COMPONENT_MAPPING_BLOCK =
      /^\s*-{2,}?\s*#{COMPONENT_MAPPING_LABEL}\s*BEGIN(.*?)#{COMPONENT_MAPPING_LABEL}\s*END.*?$/m
    SIGNAL_BLOCK = /^\s*-{2,}?\s*#{SIGNAL_LABEL}\s*BEGIN(.*?)#{SIGNAL_LABEL}\s*END.*?$/m

    RUBY_BLOCK = /^(-- )?(.*)<%(.*?)%>/

    COMPONENT_MAPPING_LINE = /(--)?(\s*)#{COMPONENT_MAPPING_LABEL}\s*$/
    COMPONENT_DEFINITION_LINE = /(--)?(\s*)#{COMPONENT_DEFINITION_LABEL}\s*$/
    SIGNAL_LINE = /(--)?(\s*)#{SIGNAL_LABEL}\s*$/

    def decorate_component_definition_block(block)
      "-- COMPONENT DEFINITION BLOCK BEGIN {{{\n#{block}\n-- COMPONENT DEFINITION BLOCK END }}}"
    end

    def decorate_component_mapping_block(block)
      "-- COMPONENT MAPPING BLOCK BEGIN {{{\n#{block}\n-- COMPONENT MAPPING BLOCK END }}}"
    end

    def decorate_signal_block(block)
      "-- SIGNAL BLOCK BEGIN {{{\n#{block}\n-- SIGNAL BLOCK END }}}"
    end

    def undecorate_component_definition_block(code)
      code.gsub(COMPONENT_DEFINITION_BLOCK) do |text|
        %q(<%= component_definitions %>)
      end
    end

    def undecorate_component_definition_line(code)
      code.gsub(COMPONENT_DEFINITION_LINE) do |text|
        %q(<%= component_definitions %>)
      end
    end

    def undecorate_component_mapping_block(code)
      code.gsub(COMPONENT_MAPPING_BLOCK) do |text|
        %q(<%= component_mappings %>)
      end
    end

    def undecorate_component_mapping_line(code)
      code.gsub(COMPONENT_MAPPING_LINE) do |text|
        %q(<%= component_mappings %>)
      end
    end

    def undecorate_signal_definition_block(code)
      code.gsub(SIGNAL_BLOCK) do |text|
        %q(<%= component_signal_definitions %>)
      end
    end

    def undecorate_signal_definition_line(code)
      code.gsub(SIGNAL_LINE) do |text|
        %q(<%= component_signal_definitions %>)
      end
    end

    def escape_ruby(text)
      text.gsub(RUBY_BLOCK) do |code|
        code = $3
        %Q(-- #{$2}<%%#{code}%>\n<%#{code}%>)
      end
    end

    def undecorate_code(text)
      text = BlockDecorator.escape_ruby(text)
      text = BlockDecorator.undecorate_component_mapping_line(text)
      text = BlockDecorator.undecorate_component_definition_line(text)
      text = BlockDecorator.undecorate_signal_definition_line(text)
      text = BlockDecorator.undecorate_component_mapping_block(text)
      text = BlockDecorator.undecorate_component_definition_block(text)
      text = BlockDecorator.undecorate_signal_definition_block(text)
      text
    end
  end
end
