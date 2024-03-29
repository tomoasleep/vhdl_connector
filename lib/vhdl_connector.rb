require 'vhdl_parser'

require "vhdl_connector/version"
require "vhdl_connector/helper"
require "vhdl_connector/presenters"
require "vhdl_connector/view"
require "vhdl_connector/connector_view"
require "vhdl_connector/connector_reader"
require "vhdl_connector/block_decorator"

require "vhdl_connector/entity_wrapper"
require "vhdl_connector/generic_wrapper"
require "vhdl_connector/port_wrapper"

module VhdlConnector
  class << self
    include VhdlConnector
  end

  def parse_entity(vhdl_str)
    EntityWrapper.new(VHDL_Parser.parse(vhdl_str))
  end

  def parse_entity_file(path)
    EntityWrapper.new(VHDL_Parser.parse_file(path))
  end

  def parse_connector(erb_path)
    ConnectorView.new(
      erb_path, Presenters::ConnectorPresenter.new, ConnectorReader.new
    ).run
  end
end
