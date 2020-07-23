require 'pry'
module XMLlint

  class XMLTag

    attr_reader :text, :state ,:title
    def initialize(tag)
      @text = tag
      @state = 'open'
      @title = tag[1..(tag.size - 2)]
      if (tag.index('/') && tag.index('/') == 1) then
        @state = 'close'
        @title = tag[2..(tag.size - 2)]
      end
    end
  end
  
  class XMLScanner
    def initialize(xml)
      @xml = xml
      @_xml = xml
    end
 
    def linter
      tags = get_all_tags
      tags_open = []
      tags_closed = []
      tags.each do |tag|
        if(tag.state == "open") then
          tags_closed << tag
        else
          tags_open << tag
        end
      end
      msj = 'nada'
      scan = true
      o = 0
      c = 0
      matches = 0
      scan = true
      while scan do
        if tags_closed[o].title == tags_open[c].title then
          matches += 1
          o += 1
          c += 1
        else
          c += 1
        end
        puts ("o " + o.to_s + " : c " + c.to_s)
        scan = false
        if c == tags_closed.size || o == tags_open.size
          scan = false
        end
      end

      if tags_closed.size == tags_open.size && tags_closed.size == matches
        msj =  'true'
      else 
        msj = tags_open[c].title == tags_open[c].title
      end
      puts msj
    end

    def get_all_tags
      scan = true
      tags = []
      while scan do
        tag = cut_next_tag
        tag ? tags << tag : scan = false
      end
      return tags
    end

    def cut_next_tag
      if (@xml.index('<') && @xml.index('>')) then
        open_index = @xml.index('<')
        close_index = @xml.index('>')
        tag = @xml[open_index..close_index]
        tag = XMLTag.new(tag)
        @xml = @xml[close_index + 1..@xml.size]
        return tag
      else
        return false
      end
    end
  end

  def xml_lint
    xml = XMLScanner.new(self)
    xml.linter

  end

  def xml_cut_next_tag
    if (self.index('<') && self.index('>')) then
      open_index = self.index('<')
      close_index = self.index('>') + 1
      return self[open_index..close_index]
    end
  end
end