require 'spec_helper'

describe VhdlConnector::BlockDecorator do
  describe '.undecorate_code' do
    let (:code) { File.read('spec/fixtures/decorated.vhd.erb') }
    subject { described_class.undecorate_code(code) }
    it 'should remove BLOCKs' do
      expect(subject).not_to match(/compdef_mark/)
      expect(subject).not_to match(/component_mark/)
      expect(subject).not_to match(/signal_mark/)
    end

    it 'should add eruby tags' do
      expect(subject).to match(/component_definitions/)
      expect(subject).to match(/component_mappings/)
      expect(subject).to match(/component_signal_definitions/)
    end

    it 'should not remove codes' do
      expect(subject.scan(/not_to_delete/).size).to eql(6)
    end
  end
end
