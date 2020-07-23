require_relative '../lib/xml-lint.rb'
include XMLlint

xml = '
<test>
  <test>gffdgdf</test>
  <test>
    <test>
      <test3>      </test3>
    </test>
  </test>
</test>'

xml2 = '
<test>
  <test2>gfd<ghdfgfdgs</test2>
  <test4>
    <test3> </test3>
  </test4>
</test>'
xml2 = '<test></test>'


xml.xml_lint

# 1.- Count that tags are paired