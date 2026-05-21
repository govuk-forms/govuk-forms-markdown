# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#link" do
  subject(:renderer) { described_class.new }

  context "when there is no title" do
    it "renders a link" do
      expected = <<~HTML.strip
        <a href="https://example.com" style="word-wrap: break-word; color: #1D70B8;">Link content</a>
      HTML

      expect(renderer.link("https://example.com", nil, "Link content")).to eq expected
    end
  end

  context "when there is a title" do
    it "renders a link with a title attribute" do
      expected = <<~HTML.strip
        <a href="https://example.com" title="Link title" style="word-wrap: break-word; color: #1D70B8;">Link content</a>
      HTML

      expect(renderer.link("https://example.com", "Link title", "Link content")).to eq expected
    end
  end
end
