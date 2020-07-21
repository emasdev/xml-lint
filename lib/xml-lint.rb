module XMLlint
  class Cutter
    
    def strip_tag(xml)
    end
  end

  def xml_lint
    xml = self.strip
    next_tag = xml.xml_find_next_tag
    next_index = 
    xml = xml[]
    puts next_tag
    # puts 'te'.index('te').is_a?(Numeric)
    # puts next_tag
    # p xml
    # puts get_string_between(xml, '<test>', '</test>')
    # xml.scan(/<.+>/) do |x| 
    #   p x
    # end
    # validate_tag = true
    # while $i < $num  do
    #     puts("Inside the loop i = #$i" )
    #     $i +=1
    # end
    # # !xml_validate_tags(xml,next_tag) ? 
    # is_valid = xml_validate_tags(xml,next_tag)
    # is_valid ?  (puts "continue") :  (puts "Be sure all your '" + next_tag + "' tags are properly closed")


    
    # puts xml
  end

  def xml_find_next_tag
    start_index = self.index('<') + 1
    end_index = self.index('>') - 1
    return self[start_index..end_index]
  end

  def find_next_child_tag

  end

  def xml_inside_tag(_tag)
    xml = self
    start_tag = '<'+_tag+'>'
    end_tag = '</'+_tag+'>'
    from_index = xml.index(start_tag) + start_tag.size
    to_index = xml.size
    xml = xml[from_index..to_index]
    to_index = 0
    cut_closed = 1
    scan = true
    puts "===================="
    while scan do
      msj = 'nothing'
      index = 0
      if(cut_closed == 0 && xml.index(start_tag).is_a?(Numeric)) then
        puts (_tag + 'is not properly closed') 
        scan = false
      elsif(cut_closed > 1 && xml.index(start_tag) > xml.index(end_tag)) then
        index = xml.index(end_tag) + end_tag.size
        cut_closed -= 1
        msj = "cut closed"
      # elsif(xml.index(end_tag) > xml.index(start_tag))
      elsif(xml.index(start_tag) && xml.index(start_tag) < xml.index(end_tag)) then
        index = xml.index(start_tag) + start_tag.size
        cut_closed += 1
        msj = "cut open"
      elsif (!xml.index(start_tag).is_a?(Numeric)) then
        scan = false
        to_index += from_index + (xml.index(end_tag) - 1)
        msj = "finish scan"
      end
      from_index += index
      xml = xml[index..xml.size]
      puts (msj + " : " + index.to_s + " : " + cut_closed.to_s)
      puts xml
    end
    
    puts (from_index.to_s + " : " + to_index.to_s)
    puts self[from_index..to_index]
  end

  def xml_inside_tag_2(_tag)
    start_index = xml.index(start_tag) + start_tag.size
    last_index = start_index
    xml = xml[last_index..xml.size]
    puts "==============================="
    puts 'cortar abierto'
    # puts xml
    scan = true
    cut_closed = 1
    while scan do
      msj = 'no paso nada'
      index = 0
      if(cut_closed > 1) then
        index = xml.index(end_tag) + xml.index(end_tag).size
        cut_closed -= 1
        msj = 'cortar cerrado'
      elsif(xml.index(start_tag) && xml.index(end_tag) > xml.index(start_tag))
        index = xml.index(start_tag) + start_tag.size
        cut_closed += 1
        msj = 'cortar abierto'
      elsif(xml.index(start_tag) && xml.index(end_tag) < xml.index(start_tag))
        index = xml.index(end_tag) + xml.index(end_tag).size
        cut_closed -= 1
        msj = 'cortar cerrado'
      elsif(cut_closed < 1)
        scan = false
      end

     
      xml = xml[index..xml.size]
      puts (msj + " : " + index.to_s)
      puts (xml.index(start_tag).to_s + " : " + xml.index(end_tag).to_s + " : " + cut_closed.to_s)
      # puts xml
    end

    # puts self[index]

    # puts self[index..self.size]
    # while scan do
    #   next_index = xml.index(start_tag)
    #   if next_index then
    #     index = next_index + start_tag.size
    #     end_index += index
    #     skip_closed_tag += 1
    #     xml = xml[index..xml.size]
    #     next_index = xml.index(end_tag)
    #     if(xml.index(end_tag) < xml.index(start_tag)) then
    #       index = next_index + start_tag.size
    #       xml = xml[index..xml.size]
    #       scan = false
    #     end 
    #   else
    #     scan = false
    #   end
    # end
    # (1..skip_closed_tag).each do |x|
    #   next_index = xml.index(end_tag)
    #   if next_index
    #     index = next_index + end_tag.size
    #     xml = xml[index..xml.size]
    #   end
    # end
    # scan = true
    # while skip_closed_tag > 0
    #     next_index = xml.index(end_tag)
    #     if next_index then
    #       index = next_index + end_tag.size
    #       xml = xml[next_index..xml.size]
    #       skip_closed_tag -= 1
    #     else
    #       scan = false
    #     end
    # end

    # while skip_closed_tag do
    #   index = xml.index(end_tag) + end_tag.size
    #   end_index += index
    #   skip_closed_tag -= 1
    #   xml = xml[index..xml.size]
    # end
 
    
    # index = xml.index(start_tag) + start_tag.size
    # end_index += index
    # puts "index==="
    # puts index
    # skip_closed_tag += 1
    # xml = xml[index..xml.size]
    # puts "===="
    # puts xml
    # index = xml.index(start_tag) + start_tag.size
    # end_index += index
    # puts "index==="
    # puts index
    # skip_closed_tag += 1
    # xml = xml[index..xml.size]
    # puts "===="
    # puts xml
    # (1..skip_closed_tag).each do |x|
    #   puts "this"
    #   index = xml.index(end_tag) + end_tag.size
    #   end_index += index
    #   xml = xml[index..xml.size]
    # end
    # puts "===="
    # puts xml
    # puts "===="
    # puts end_index
    # puts "===="
    # puts self[start_index..end_index].strip



      
  end

  def xml_tags_closed?(_xml, _tag)
    open_tags = 0
    closed_tags = 0
    _xml.scan('<'+_tag+'>') {|x| open_tags += 1}
    _xml.scan('</'+_tag+'>') {|x| closed_tags += 1}
    return open_tags == closed_tags
  end
  def get_string_between(my_string, start_at, end_at)
    my_string = " #{my_string}"
    ini = my_string.index(start_at)
    return my_string if ini == 0
    ini += start_at.length
    length = my_string.index(end_at, ini).to_i - ini
    my_string[ini,length]
end
end