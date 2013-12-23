require 'spec_helper'

module VhdlConnector::Presenters
  describe ConnectorPresenter do
    describe '#commponents' do
      subject { ConnectorPresenter.new.components(entity_path, options) }
      let(:entity_path) { './examples/no_generics_entity.vhd' } 

      context 'add no generic entity' do
        let(:options) { Hash.new }

        it { expect(subject.size).to be(1) }
      end

      context 'add no generic entity with named alias' do
        let(:options) { { as: { alu: 'java' } } }

        it { expect(subject.size).to be(1) }
        it { expect(subject.first.local_name).to eq('java') }
      end

      context 'add no generic entity with named aliases' do
        let(:options) { { as: { alu: %w(java internet) } } }

        it { expect(subject.size).to be(2) }
      end

      context 'add no generic entity with alias' do
        let(:options) { {as: 'java' } }

        it { expect(subject.size).to be(1) }
        it { expect(subject.first.local_name).to eq('java') }
      end
    end

    describe '#component_definitions_obj' do
      subject { ConnectorPresenter.new(entities: entities).component_definitions_obj }
      let(:entities) { entity_pathes.map { |path| VhdlConnector.parse_entity_file(path) } }

      context 'use no generic entity' do
        let(:entity_pathes) { %w{./examples/no_generics_entity.vhd} } 

        it { expect(subject.size).to be(1) }
        it { expect(subject.first).to match %r{port\(\s*a\s*:\s*in\s*std_logic_vector} }
      end
    end
  end
end
