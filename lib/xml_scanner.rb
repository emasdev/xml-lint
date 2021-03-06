# frozen_string_literal: true

require_relative 'xml_tag.rb'
# A class to scan XML strings
class XMLScanner
  def initialize(xml)
    @xml = xml
    @_xml = xml
  end

  def cut_schema
    return unless @xml.index('<?') && @xml.index('?>')

    @xml = @xml[@xml.index('?>') + 2..@xml.size]
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
    conflicted_tags_text = "\nError: some tags are not properly closed\n"
    conflicted_tags_text += "Verify this tags:\n"
    tags.each do |tag|
      conflicted_tags_text += tag.text + "\n"
    end

    if (number_of_tags / 2) == matches
      puts 'XML document is valid'
      true
    else
      puts conflicted_tags_text
      false
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
