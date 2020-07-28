# frozen_string_literal: true

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
