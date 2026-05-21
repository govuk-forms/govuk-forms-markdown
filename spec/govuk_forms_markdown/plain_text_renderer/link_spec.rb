# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#link" do
  subject(:renderer) { described_class.new }

  context "when there is no title" do
    it "renders a link" do
      expect(renderer.link("https://example.com", nil, "Link content")).to eq("Link content: https://example.com")
    end
  end

  context "when there is a title" do
    it "renders a link" do
      expect(renderer.link("https://example.com", "Link title", "Link content")).to eq("Link content (Link title): https://example.com")
    end
  end
end
