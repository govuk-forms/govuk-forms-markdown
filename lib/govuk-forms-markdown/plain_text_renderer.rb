module GovukFormsMarkdown
  class PlainTextRenderer < ::Redcarpet::Render::Safe
    class Error < StandardError; end

    attr_reader :errors

    # Redcarpet builds lists in two passes (list_item, then list). We tag each item
    # with this unlikely string and replace it with bullets or numbers in #list.
    MAGIC_SEQUENCE = "🇬🇧🕶️📋️".freeze

    def initialize(options = {})
      super options
      @errors = []
    end

    def header(text, _header_level)
      paragraph(text)
    end

    def paragraph(text)
      if text.to_s.strip != ""
        (linebreak * 2) + text
      else
        ""
      end
    end

    def block_quote(quote)
      quote
    end

    def hrule
      "#{linebreak * 2}---"
    end

    def codespan(code)
      add_to_error(:used_codespan)
      code
    end

    def emphasis(text)
      add_to_error(:used_emphasis)
      text
    end

    def double_emphasis(text)
      add_to_error(:used_emphasis)
      text
    end

    def triple_emphasis(text)
      add_to_error(:used_emphasis)
      text
    end

    def link(link, title, content)
      result = content.to_s
      result += " (#{title})" unless title.nil? || title == ""
      "#{result}: #{link}"
    end

    def list(contents, list_type)
      counter = 0
      if list_type == :ordered
        contents.gsub(MAGIC_SEQUENCE) { "#{counter += 1}." }
      elsif list_type == :unordered
        contents.gsub(MAGIC_SEQUENCE, "•")
      else
        raise GovukFormsMarkdown::Error, "Unexpected type #{list_type.inspect}"
      end
    end

    def list_item(text, _list_type)
      "#{linebreak}#{MAGIC_SEQUENCE} #{text.strip}"
    end

    def inline_callout(text)
      paragraph(text)
    end

    def block_callout(text)
      text
    end

    def postprocess(document)
      document_with_block_callouts = render_block_callouts(document)
      render_inline_callouts(document_with_block_callouts)
    end

  private

    def add_to_error(error)
      symbolized_error = error.to_sym
      errors << symbolized_error unless errors.include?(symbolized_error)
    end

    def linebreak
      "\n"
    end

    def render_block_callouts(text)
      block_callout_regex = /(?:\^\^\^)((.|\s)*)(?:\^\^\^)/

      text.gsub(block_callout_regex, block_callout('\1'))
    end

    def render_inline_callouts(text)
      inline_callout_regex = /(?:\^)(.*)(?:\^)/

      text.gsub(inline_callout_regex, inline_callout('\1'))
    end
  end
end
