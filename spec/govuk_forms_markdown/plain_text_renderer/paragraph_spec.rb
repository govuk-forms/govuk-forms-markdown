# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#paragraph" do
  subject(:renderer) { described_class.new }

  it "renders a paragraph as plain text" do
    expect(renderer.paragraph("This is some paragraph text")).to eq "\n\nThis is some paragraph text"
  end
end
