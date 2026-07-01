# frozen_string_literal: true

module GovukFormsMarkdown
  # Uses the formatting from Notify, defined in
  # https://github.com/alphagov/notifications-utils/blob/fad26d684f87a832cc54cee072844ad5dccd2305/notifications_utils/markdown.py
  class EmailRenderer < ::Redcarpet::Render::Safe
    class Error < StandardError; end

    attr_reader :errors

    def initialize(options = {}, allow_headings: true)
      super options
      @allow_headings = allow_headings
      @errors = []
    end

    def header(text, header_level)
      if !@allow_headings
        add_to_error(:headings_not_allowed)
        paragraph(text)
      elsif header_level == 2
        <<~HTML
          <h2 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 27px; line-height: 35px; font-weight: bold; color: #0B0C0C;">
            #{text}
          </h2>
        HTML
      elsif header_level == 3
        <<~HTML
          <h3 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 21px; line-height: 25px; font-weight: bold; color: #0B0C0C;">
            #{text}
          </h3>
        HTML
      elsif header_level == 4
        <<~HTML
          <h4 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 19px; line-height: 25px; font-weight: bold; color: #0B0C0C;">
            #{text}
          </h4>
        HTML
      elsif header_level == 5
        <<~HTML
          <h5 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 16px; line-height: 20px; font-weight: bold; color: #0B0C0C;">
            #{text}
          </h5>
        HTML
      else
        add_to_error(:heading_levels)
        paragraph(text)
      end
    end

    def paragraph(text)
      <<~HTML
        <p>#{text}</p>
      HTML
    end

    def block_quote(quote)
      add_to_error(:used_block_quote)
      paragraph(quote)
    end

    def hrule
      <<~HTML
        <hr style="border: 0; height: 1px; background: #B1B4B6; Margin: 30px 0 30px 0;">
      HTML
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
      title_attribute = title.nil? ? "" : " title=\"#{title}\""
      <<~HTML.chomp
        <a href="#{link}"#{title_attribute} style="word-wrap: break-word; color: #1D70B8;">#{content}</a>
      HTML
    end

    def autolink(link, link_type)
      href = link_type == :email ? "mailto:#{link}" : link
      <<~HTML.chomp
        <a href="#{href}" style="word-wrap: break-word; color: #1D70B8;">#{link}</a>
      HTML
    end

    def list(contents, list_type)
      if list_type == :unordered
        <<~HTML
          <table role="presentation" style="padding: 0 0 20px 0;">
            <tr>
              <td style="font-family: Helvetica, Arial, sans-serif;">
                <ul style="Margin: 0 0 0 20px; padding: 0; list-style-type: disc;">
                  #{contents}
                </ul>
              </td>
            </tr>
          </table>
        HTML
      elsif list_type == :ordered
        <<~HTML
          <table role="presentation" style="padding: 0 0 20px 0;">
            <tr>
              <td style="font-family: Helvetica, Arial, sans-serif;">
                <ol style="Margin: 0 0 0 20px; padding: 0; list-style-type: decimal;">
                  #{contents}
                </ol>
              </td>
            </tr>
          </table>
        HTML
      else
        raise GovukFormsMarkdown::Error, "Unexpected type #{list_type.inspect}"
      end
    end

    def list_item(text, _list_type)
      <<~HTML
        <li style="Margin: 5px 0 5px; padding: 0 0 0 5px; font-size: 19px; line-height: 25px; color: #0B0C0C;">
          #{text}
        </li>
      HTML
    end

    def linebreak
      <<~HTML
        <br/>
      HTML
    end

    def inline_callout(text)
      <<~HTML
        <div style="margin: 0 0 20px 0; border-left: 10px solid #B1B4B6; padding: 15px 0 0.1px 15px; font-size: 19px; line-height: 25px;">
          <p style="margin: 0 0 20px 0">#{text}</p>
        </div>
      HTML
    end

    def block_callout(text)
      <<~HTML
        <div style="margin: 0 0 20px 0; border-left: 10px solid #B1B4B6; padding: 15px 0 0.1px 15px; font-size: 19px; line-height: 25px;">
          #{text}
        </div>
      HTML
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

    def render_block_callouts(text)
      block_callout_regex = /<p>(?:\^\^\^)<\/p>((.|\s)*)<p>(?:\^\^\^)<\/p>/

      text.gsub(block_callout_regex, block_callout('\1'))
    end

    def render_inline_callouts(text)
      inline_callout_regex = /<p>(?:\^)(.*)(?:\^)<\/p>/

      text.gsub(inline_callout_regex, inline_callout('\1'))
    end
  end
end
