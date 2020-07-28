# frozen_string_literal: true

require_relative '../lib/xml_scanner.rb'

# rubocop:disable Metrics/BlockLength
describe XMLScanner do
  context 'cutting string methods' do
    it 'cut schema from xml' do
      xml = '<?xml version="1.0" encoding="UTF-8"?>'
      scanner = XMLScanner.new(xml)
      expect(scanner.cut_schema).to eq ''
    end

    it 'cut next tag' do
      xml = '<test></test>'
      scanner = XMLScanner.new(xml)
      expect(scanner.cut_next_tag.text).to eq '<test>'
    end

    it 'if no more tags to cut' do
      xml = 'no more tags'
      scanner = XMLScanner.new(xml)
      expect(scanner.cut_next_tag).to eq false
    end
  end

  context 'working with tags' do
    it 'get all tags from xml' do
      xml = '
      <first>
        <second>
          <third></third>
        </second>
      </first>'
      scanner = XMLScanner.new(xml)
      expect(scanner.all_tags.size).to eq 6
    end

    describe 'check if tag is closed' do
      it 'tag is closed' do
        xml = '<test></test>'
        scanner = XMLScanner.new(xml)
        tag_a = scanner.cut_next_tag
        tag_b = scanner.cut_next_tag
        expect(scanner.tag_closed?(tag_a, tag_b)).to eq true
      end

      it 'tag is not closed' do
        xml = '<test><test2></test2></test>'
        scanner = XMLScanner.new(xml)
        tag_a = scanner.cut_next_tag
        tag_b = scanner.cut_next_tag
        expect(scanner.tag_closed?(tag_a, tag_b)).to eq false
      end
    end
  end

  context 'linter method' do
    it 'should return true for a valid xml' do
      xml = '
      <?xml version="1.0" encoding="UTF-8"?>
      <first>
        <second>
          <third></third>
        </second>
      </first>'
      scanner = XMLScanner.new(xml)
      expect(scanner.linter).to eq true
    end

    it 'should return false for invalid xml' do
      xml = '
      <?xml version="1.0" encoding="UTF-8"?>
      <first>
        <error>
          <third></third>
        </second>
      </first>'
      scanner = XMLScanner.new(xml)
      expect(scanner.linter).to eq false
    end
  end
end
# rubocop:enable Metrics/BlockLength
