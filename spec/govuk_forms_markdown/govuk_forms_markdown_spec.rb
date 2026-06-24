# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown do
  it "has a version number" do
    expect(GovukFormsMarkdown::VERSION).not_to be_nil
  end

  describe ".render" do
    it "does not render tables" do
      markdown =
        <<~MD
          | First name   | Last name    | DOB        |
          | ------------ | ------------ | ---------- |
          | John         | Smith        | 01-04-1970 |
          | Alison       | Brown        | 02-05-1970 |
          | Adam         | Sample       | 03-06-1970 |
        MD

      expected_html = <<~HTML
        <p class="govuk-body">
          | First name   | Last name    | DOB        |
          | ------------ | ------------ | ---------- |
          | John         | Smith        | 01-04-1970 |
          | Alison       | Brown        | 02-05-1970 |
          | Adam         | Sample       | 03-06-1970 |
        </p>
      HTML

      expect_equal_ignoring_ws(render(markdown), expected_html)
    end

    it "renders H2s and GOV.UK classes" do
      expect(render("## Top heading")).to eq('<h2 class="govuk-heading-m">Top heading</h2>')
    end

    it "renders H3s with ids and GOV.UK classes" do
      expect(render("### A heading")).to eq('<h3 class="govuk-heading-s">A heading</h3>')
    end

    it "renders paragraphs with GOV.UK classes" do
      expect(render("abc")).to eq('<p class="govuk-body">abc</p>')
    end

    it "renders code without emphasis" do
      expect(render("I am a snake_cased_word")).to include("snake_cased_word")
    end

    it "renders unordered lists with GOV.UK classes" do
      input = <<~MARKDOWN
        * abc def
        * xyz
      MARKDOWN
      expected = <<~HTML
        <ul class="govuk-list govuk-list--bullet">
          <li>abc def</li>
        <li>xyz</li>

        </ul>
      HTML
      expect(render(input)).to eq(expected.strip)
    end

    it "renders ordered lists with GOV.UK classes" do
      input = <<~MARKDOWN
        1. abc def
        2. xyz
      MARKDOWN
      expected_html = <<~HTML
        <ol class="govuk-list govuk-list--number">
          <li>abc def</li>
          <li>xyz</li>
        </ol>
      HTML
      expect_equal_ignoring_ws(render(input), expected_html)
    end

    it "renders a URL in angle brackets with GOV.UK classes" do
      expect(render("<https://www.gov.uk/help>")).to eq(
        '<p class="govuk-body"><a href="https://www.gov.uk/help" class="govuk-link" rel="noreferrer noopener" target="_blank">https://www.gov.uk/help</a></p>',
      )
    end

    it "renders an email address in angle brackets with GOV.UK classes" do
      expect(render("<noreply@gov.uk>")).to eq(
        '<p class="govuk-body"><a href="mailto:noreply@gov.uk" class="govuk-link" rel="noreferrer noopener" target="_blank">noreply@gov.uk</a></p>',
      )
    end

    it "does not render hrules with GOV.UK classes" do
      expect(render("---")).to eq ""
    end

    it "does not render code blocks" do
      expect(render("    An indented code block")).to eq "<p class=\"govuk-body\">    An indented code block</p>"
    end

    context "when unsafe content is used it should be escaped" do
      it "renders escaped H2s and GOV.UK classes" do
        expect(render("## <script>alert('Hacked');</script>")).to eq('<h2 class="govuk-heading-m">&lt;script&gt;alert(&#39;Hacked&#39;);&lt;/script&gt;</h2>')
      end

      it "renders escaped p and GOV.UK classes" do
        input = <<~MARKDOWN
          <script>alert('Hacked');</script>

          <script>alert('Hacked');</script>

          <script>alert('Hacked');</script>
        MARKDOWN

        expected_html = <<~HTML
          <p class="govuk-body">&lt;script&gt;alert(&#39;Hacked&#39;);&lt;/script&gt;</p>
          <p class="govuk-body">&lt;script&gt;alert(&#39;Hacked&#39;);&lt;/script&gt;</p>
          <p class="govuk-body">&lt;script&gt;alert(&#39;Hacked&#39;);&lt;/script&gt;</p>
        HTML

        expect_equal_ignoring_ws(render(input), expected_html)
      end

      it "escapes html tags" do
        input = <<~MARKDOWN
          <div>My new section</div>

          <p>Let me add my own paragraph tags</p>

          <ul>
            <li>List with one item</li>
          </ul>
        MARKDOWN

        expected_html = <<~HTML
          <p class="govuk-body">&lt;div&gt;My new section&lt;/div&gt;</p>
          <p class="govuk-body">&lt;p&gt;Let me add my own paragraph tags&lt;/p&gt;</p>
          <p class="govuk-body">&lt;ul&gt;\n  &lt;li&gt;List with one item&lt;/li&gt;\n&lt;/ul&gt;</p>
        HTML

        expect_equal_ignoring_ws(render(input), expected_html)
      end
    end

    context "when configured with an unsupported locale" do
      it "raises a GovukFormsMarkdown::Error" do
        expect { described_class.render("## Top heading", locale: "fr") }.to raise_error(GovukFormsMarkdown::Error, "Unsupported locale \"fr\"")
      end
    end
  end

  describe ".render_plain_text" do
    it "renders a paragraph as plain text" do
      expect(described_class.render_plain_text("abc")).to eq("abc")
    end

    it "renders headings as a paragraph" do
      expect(described_class.render_plain_text("# Heading level 1")).to eq("Heading level 1")
    end

    it "renders unordered lists with bullets" do
      input = <<~MARKDOWN
        * abc def
        * xyz
      MARKDOWN

      expect(described_class.render_plain_text(input)).to eq("• abc def\n• xyz")
    end

    it "renders ordered lists with numbers" do
      input = <<~MARKDOWN
        1. abc def
        2. xyz
      MARKDOWN

      expect(described_class.render_plain_text(input)).to eq("1. abc def\n2. xyz")
    end

    it "renders links as text: url" do
      expect(described_class.render_plain_text("[Gov.uk](https://www.gov.uk)")).to eq("Gov.uk: https://www.gov.uk")
    end

    it "renders horizontal rules as three dashes" do
      expect(described_class.render_plain_text("---")).to eq("---")
    end

    it "renders the inline callout" do
      expect(described_class.render_plain_text("^Callout text^")).to eq("Callout text")
    end

    it "renders the block callout" do
      expect(described_class.render_plain_text("^^^\n\n## Heading\n\nparagraph content\n\n^^^")).to eq("Heading\n\nparagraph content")
    end
  end

  describe ".render_for_email" do
    it "renders H2s with email inline styles" do
      expected_html = <<~HTML
        <h2 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 27px; line-height: 35px; font-weight: bold; color: #0B0C0C;">
          Top heading
        </h2>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("## Top heading"), expected_html)
    end

    it "renders H3s with email inline styles" do
      expected_html = <<~HTML
        <h3 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 19px; line-height: 25px; font-weight: bold; color: #0B0C0C;">
          A heading
        </h3>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("### A heading"), expected_html)
    end

    it "renders H4s with email inline styles" do
      expected_html = <<~HTML
        <h4 style="font-size: 19px; line-height: 25px; font-weight: bold; color: #0B0C0C;">
          A heading
        </h4>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("#### A heading"), expected_html)
    end

    it "renders paragraphs" do
      expect(described_class.render_for_email("abc")).to eq("<p>abc</p>")
    end

    it "renders a link" do
      expected_html = <<~HTML
        <p><a href="https://www.gov.uk" style="word-wrap: break-word; color: #1D70B8;">Some text</a>.</p>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("[Some text](https://www.gov.uk)."), expected_html)
    end

    it "renders a URL with email inline styles" do
      expected_html = <<~HTML
        <p><a href="https://www.gov.uk/help" style="word-wrap: break-word; color: #1D70B8;">https://www.gov.uk/help</a>.</p>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("<https://www.gov.uk/help>."), expected_html)
    end

    it "renders an email address with email inline styles" do
      expected_html = <<~HTML
        <p><a href="mailto:noreply@gov.uk" style="word-wrap: break-word; color: #1D70B8;">noreply@gov.uk</a></p>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("<noreply@gov.uk>"), expected_html)
    end

    it "renders a styled horizontal rule" do
      expected_html = <<~HTML
        <hr style="border: 0; height: 1px; background: #B1B4B6; Margin: 30px 0 30px 0;">
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("---"), expected_html)
    end

    it "renders the inline callout" do
      expected_html = <<~HTML
        <div style="margin: 0 0 20px 0; border-left: 10px solid #B1B4B6; padding: 15px 0 0.1px 15px; font-size: 19px; line-height: 25px;"><p style="margin: 0 0 20px 0">Callout text</p></div>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("^Callout text^"), expected_html)
    end

    it "renders the block callout" do
      expected_html = <<~HTML
        <div style="margin: 0 0 20px 0; border-left: 10px solid #B1B4B6; padding: 15px 0 0.1px 15px; font-size: 19px; line-height: 25px;">
          <h2 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 27px; line-height: 35px; font-weight: bold; color: #0B0C0C;">Heading</h2>
          <p>paragraph content</p>
        </div>
      HTML

      expect_equal_ignoring_ws(described_class.render_for_email("^^^\n\n## Heading\n\nparagraph content\n\n^^^"), expected_html)
    end
  end

  describe ".validate" do
    it "returns JSON with error key being an empty array" do
      expect(validate("## Heading level 2")[:errors]).to be_empty
    end

    context "when markdown is too long" do
      it "returns JSON with error key containing too_long" do
        expect(validate("A" * 5000)[:errors]).to eq [:too_long]
      end
    end

    context "when markdown is using unsupported syntax" do
      it "returns JSON with error key containing heading_levels" do
        expect(validate("# Heading level 1")[:errors]).to eq [:heading_levels]
      end
    end

    context "when markdown is to long and using unsupported syntax" do
      it "returns JSON with error key containing multiple symbols" do
        expect(validate("# Heading level 1" * 5000)[:errors]).to eq %i[too_long heading_levels]
      end
    end
  end
end
