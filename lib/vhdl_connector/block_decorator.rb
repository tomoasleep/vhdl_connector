module VhdlConnector
  module BlockDecorator
    extend self
    COMPONENT_DEFINITION_BLOCK =
      /^\s*--\s*COMPONENT\s*DEFINITION\s*BLOCK\s*BEGIN(.*?)--\s*COMPONENT\s*DEFINITION\s*BLOCK\s*END.*$/
    COMPONENT_MAPPING_BLOCK =
      /^\s*--\s*COMPONENT\s*MAPPING\s*BLOCK\s*BEGIN(.*?)--\s*COMPONENT\s*MAPPING\s*BLOCK\s*END.*$/
    SIGNAL_BLOCK = /^\s*--\s*SIGNAL\s*BLOCK\s*BEGIN(.*?)--\s*SIGNAL\s*BLOCK\s*END.*$/
    RUBY_BLOCK = /^(-- )?(.*)<%(.*?)%>/

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

    def undecorate_component_mapping_block(code)
      code.gsub(COMPONENT_MAPPING_BLOCK) do |text|
        %q(<%= component_mappings %>)
      end
    end

    def undecorate_signal_definition_block(code)
      code.gsub(COMPONENT_DEFINITION_BLOCK) do |text|
        %q(<%= component_signal_definitions %>)
      end
    end

    def escape_ruby(text)
      text.gsub(RUBY_BLOCK) do |code|
        code = $3
        %Q(-- #{$2}<%%#{code}%>\n<%#{code}%>)
      end
    end
  end
end
