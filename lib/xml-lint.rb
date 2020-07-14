module XMLlint
  def xml_lint(_xml)
    xml = _xml.strip
    next_tag = xml_find_next_tag(xml)
    # !xml_validate_tags(xml,next_tag) ? 
    is_valid = xml_validate_tags(xml,next_tag)
    is_valid ?  (puts "continue") :  (puts "Be sure all your '" + next_tag + "' are properly closed")


    #
    # puts xml
  end

  def xml_find_next_tag(_xml)
    start_index = _xml.index('<') + 1
    end_index = _xml.index('>') - 1
    return _xml[start_index..end_index]
  end

  def xml_inside_tag(_xml, _tag)
    start_tag = '<'+_tag+'>'
    end_tag = '</'+_tag+'>'
    start_index = _xml.index(start_tag) + start_tag.size
    end_index = _xml.rindex(end_tag) -1
    return _xml[start_index..end_index]
  end

  def xml_validate_tags(_xml, _tag)
    open_tags = 0
    closed_tags = 0
    _xml.scan('<'+_tag+'>')do
      |x| open_tags += 1
    end
    _xml.scan('</'+_tag+'>')do
      |x| closed_tags += 1
    end
    return open_tags == closed_tags
  end
end