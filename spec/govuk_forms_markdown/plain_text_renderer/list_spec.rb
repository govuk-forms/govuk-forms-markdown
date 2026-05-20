# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#list" do
  subject(:renderer) { described_class.new }

  context "when displaying an unordered list" do
    it "renders bullets for list items" do
      contents = renderer.list_item("abc", :unordered) + renderer.list_item("xyz", :unordered)
      expect(renderer.list(contents, :unordered)).to eq("\n• abc\n• xyz")
    end
  end

  context "when displaying an ordered list" do
    it "renders numbered markers for list items" do
      contents = renderer.list_item("abc", :ordered) + renderer.list_item("xyz", :ordered)
      expect(renderer.list(contents, :ordered)).to eq("\n1. abc\n2. xyz")
    end
  end

  context "when displaying an unsupported list" do
    it "raises an error" do
      expect { renderer.list("My list of items", :not_supported_type) }.to raise_error(GovukFormsMarkdown::Error, "Unexpected type :not_supported_type")
    end
  end
end
