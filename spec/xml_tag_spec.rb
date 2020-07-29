# frozen_string_literal: true

require_relative '../lib/xml_tag.rb'

describe XMLTag do
  context 'create tag' do
    it 'is an open tag' do
      tag = XMLTag.new('<tag>')
      expect(tag.state).to eq 'open'
    end
    it 'is a close tag' do
      tag = XMLTag.new('</tag>')
      expect(tag.state).to eq 'close'
    end
  end
end
