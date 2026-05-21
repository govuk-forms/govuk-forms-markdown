# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#autolink" do
  subject(:renderer) { described_class.new }

  context "when autolinking a URL" do
    it "renders a styled link" do
      expected = <<~HTML.strip
        <a href="https://example.com" style="word-wrap: break-word; color: #1D70B8;">https://example.com</a>
      HTML

      expect(renderer.autolink("https://example.com", :url)).to eq expected
    end
  end

  context "when autolinking an email address" do
    it "renders a mailto styled link" do
      expected = <<~HTML.strip
        <a href="mailto:noreply@example.com" style="word-wrap: break-word; color: #1D70B8;">noreply@example.com</a>
      HTML

      expect(renderer.autolink("noreply@example.com", :email)).to eq expected
    end
  end
end
