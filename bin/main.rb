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

xml_test2 = '
<test>
  <test2>gfd<ghdfgfdgs</test2>
  <test4>
    <test3> </test3>
  </test4>
</test>'
xml_test3 = '<te>st></test>'

xml_test4 = '
<test>
  <test>dsfdsfdsfsd</test>
  <te>st3>gffdgdf</test3>
</test>'

xml_test5 = '
<?xml version="1.0" encoding="UTF-8"?>
<test>
  <test3>dsfdsfdsfsd</test3>
  <test>gffdgdf</test3>
  <test3>gsgs</test4>
</test>'

# rubocop:enable Lint/UselessAssignment

xml_test1.xml_lint
