# frozen_string_literal: true

require_relative '../lib/xml_lint.rb'
# rubocop:disable Style/MixinUsage
include XMLlint
# rubocop:enable Style/MixinUsage

# rubocop:disable Lint/UselessAssignment
xml_test1 = '
<?xml version="1.0" encoding="UTF-8"?>
<test>
  <test>gffdgdf</test>
  <test>
    <test>
      <test3>      </test3>
    </test>
  </test>
</test>'
# rubocop:enable Lint/UselessAssignment

xml_file = File.open('./docs/test5.xml')
xml = xml_file.read
xml.xml_lint
