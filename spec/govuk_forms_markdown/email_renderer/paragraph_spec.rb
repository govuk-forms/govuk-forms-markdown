# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#paragraph" do
  subject(:renderer) { described_class.new }

  it "wraps text in p tags" do
    expect(renderer.paragraph("Some text").strip).to eq "<p>Some text</p>"
  end

  it "returns empty p for empty string" do
    expect(renderer.paragraph("").strip).to eq "<p></p>"
  end
end
