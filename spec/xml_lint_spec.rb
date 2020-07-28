# frozen_string_literal: true

require_relative '../lib/xml_lint.rb'
# rubocop:disable Style/MixinUsage
include XMLlint
# rubocop:enable Style/MixinUsage

describe XMLlint do
  context 'linter for an xml document' do
    it 'is a valid document' do
      xml = '
      <?xml version="1.0" encoding="UTF-8"?>
      <first>
        <second>
          <third></third>
        </second>
      </first>'

      expect(xml.xml_lint).to eq true
    end
  end
end
