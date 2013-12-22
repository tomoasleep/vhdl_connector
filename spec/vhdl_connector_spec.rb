require 'spec_helper'

describe VhdlConnector do
  it 'should have a version number' do
    VhdlConnector::VERSION.should_not be_nil
  end
end
