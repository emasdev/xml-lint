# frozen_string_literal: true

require_relative 'xml_scanner.rb'
# A module for linter XML documents
module XMLlint
  def xml_lint
    xml = XMLScanner.new(self)
    xml.linter
  end
end
