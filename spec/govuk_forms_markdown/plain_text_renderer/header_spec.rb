# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#header" do
  subject(:renderer) { described_class.new }

  it "renders headings as a paragraph" do
    expect(renderer.header("A heading", 1)).to eq "\n\n\A heading"
  end
end
