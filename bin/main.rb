require_relative '../lib/xml-lint.rb'
include XMLlint

xml = '
<test>
  <test>gfdgfdgdf</test>
  <test>
    <test>
      <test3>      </test3>
    </test>
  </test>
</test>'

xml2 = '
<test>
  <test>gfd<tesdt> </tes><ghdfgfdgs</test>
  <test2>
    <test3>
    </test3>
  </test2>
</test>'

xml2.xml_lint