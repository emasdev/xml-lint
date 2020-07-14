require_relative '../lib/xml-lint.rb'
include XMLlint

xml = '
<test>
  Something inside
  <stuff1></stuff1>
  <test></test>
</test'

xml_lint(xml)