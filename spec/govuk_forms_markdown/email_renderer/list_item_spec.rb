# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#list_item" do
  subject(:renderer) { described_class.new }

  it "renders a list item with inline styles" do
    expected = <<~HTML.strip
      <li style="Margin: 5px 0 5px; padding: 0 0 0 5px; font-size: 19px; line-height: 25px; color: #0B0C0C;">
        An item
      </li>
    HTML

    expect(renderer.list_item("An item", :unordered).strip).to eq expected
  end
end
