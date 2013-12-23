require 'spec_helper'

module VhdlConnector::Presenters
  describe ConnectorPresenter do
    describe '#header_obj' do
      subject { ConnectorPresenter.new(entities: entities).header_obj }
      let(:entities) { entity_pathes.map { |path| VhdlConnector.parse_entity_file(path) } }

      context 'use no generic entity' do
        let(:entity_pathes) { %w{./examples/no_generics_entity.vhd} } 

        it do
          expect(subject.size).to be(1)
          expect(subject.first).to match %r{port\(\s*a\s*:\s*in\s*std_logic_vector}
        end
      end
    end
  end
end
