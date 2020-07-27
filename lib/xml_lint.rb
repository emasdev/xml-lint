# frozen_string_literal: true

# A module for linter XML documents
module XMLlint
  # A class for xml tags
  class XMLTag
    attr_reader :text, :state, :title
    def initialize(tag)
      @text = tag
      @state = 'open'
      @title = tag[1..(tag.size - 2)]
      return unless tag.index('/') && tag.index('/') == 1

      @state = 'close'
      @title = tag[2..(tag.size - 2)]
    end
  end

  # A class to scan XML strings
  class XMLScanner
    def initialize(xml)
      @xml = xml
      @_xml = xml
    end

    def cut_schema
      @xml = @xml[@xml.index('?>') + 2..@xml.size] if @xml.index('<?') && @xml.index('?>')
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def linter
      cut_schema
      tags = all_tags
      number_of_tags = tags.size
      scan = true
      i = 0
      matches = 0
      while scan
        if tag_closed?(tags[i], tags[i + 1])
          tags.delete_at(i)
          tags.delete_at(i)
          matches += 1
          i = 0
        else
          i += 1
        end

        scan = false if (i + 1) > tags.size
      end
      conflicted_tags_text = "Error: some tags are not properly closed\nVerify this tags:\n"
      tags.each do |tag|
        conflicted_tags_text += tag.text + ' '
      end

      if (number_of_tags / 2) == matches
        puts 'XML document is valid'
      else
        puts conflicted_tags_text
      end
    end

    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    def tag_closed?(tag_a, tag_b)
      if tag_a && tag_b &&
         ((tag_a.state == 'open') && (tag_b.state == 'close')) &&
         (tag_a.title == tag_b.title)
        true
      else
        false
      end
    end

    def all_tags
      scan = true
      tags = []
      while scan
        tag = cut_next_tag
        tag ? tags << tag : scan = false
      end
      tags
    end

    def cut_next_tag
      if @xml.index('<') && @xml.index('>')
        open_index = @xml.index('<')
        close_index = @xml.index('>')
        tag = @xml[open_index..close_index]
        tag = XMLTag.new(tag)
        @xml = @xml[close_index + 1..@xml.size]
        tag
      else
        false
      end
    end
  end

  def xml_lint
    xml = XMLScanner.new(self)
    xml.linter
  end

  def xml_cut_next_tag
    return unless index('<') && index('>')

    open_index = index('<')
    close_index = index('>') + 1
    self[open_index..close_index]
  end
end
