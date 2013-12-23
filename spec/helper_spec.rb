require 'spec_helper'

module VhdlConnector
  describe Helper do
    class << Helper
      include Helper
    end

    describe '#options_of_args' do
      subject { Helper.options_of_args(args) }

      context 'arguments without options' do
        let(:args) { %w(java internet) }
        it { expect(subject.is_a? Hash).to be_true }
        it { expect(subject.size).to be(0) }
      end

      context 'arguments with options' do
        let(:args) { ['java', 'internet', {java: true}] }
        it { expect(subject.size).to be(1) }
      end
    end

    describe '#args_without_options' do
      subject { Helper.args_without_options(args) }

      context 'arguments without options' do
        let(:args) { %w(java internet) }
        it { expect(subject.size).to be(2) }
      end

      context 'arguments with options' do
        let(:args) { ['java', 'internet', {java: true}] }
        it { expect(subject.size).to be(2) }
      end
    end
  end
end
