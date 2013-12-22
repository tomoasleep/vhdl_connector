require 'spec_helper'

module VhdlConnector
  describe EntityWrapper do
    describe '#to_component_definition' do
      subject(:entity_wrapper) { VhdlConnector.parse_entity_file(entity_path).to_component_definition }

      context 'parse no generic entity' do
        let(:entity_path) { './examples/no_generics_entity.vhd' }

        # TODO better matcher
        it do
          expect(subject).to match %r{port\(\s*a\s*:\s*in\s*std_logic_vector}
        end
      end
    end

    describe '#to_component_mapping' do
      subject(:entity_wrapper) { VhdlConnector.parse_entity_file(entity_path).to_component_mapping }

      context 'parse no generic entity' do
        let(:entity_path) { './examples/no_generics_entity.vhd' }

        # TODO better matcher
        it do
          expect(subject).to match %r{port map\(\s*a\s*=>\s*alu_a}
        end
      end
    end
  end
end
