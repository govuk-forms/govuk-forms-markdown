# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#list" do
  subject(:renderer) { described_class.new }

  context "when displaying an unordered list" do
    it "wraps contents in a table and ul with email-safe styles" do
      contents = "A list of values"
      expected_html = <<~HTML
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

      expect(renderer.list(contents, :unordered)).to eq expected_html
    end
  end

  context "when displaying an ordered list" do
    it "wraps contents in a table and ol with email-safe styles" do
      contents = "A list of values"
      expected_html = <<~HTML
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

      expect(renderer.list(contents, :ordered)).to eq expected_html
    end
  end

  context "when displaying an unsupported list" do
    it "raises an error" do
      expect { renderer.list("My list of items", :not_supported_type) }.to raise_error(GovukFormsMarkdown::Error, "Unexpected type :not_supported_type")
    end
  end
end
