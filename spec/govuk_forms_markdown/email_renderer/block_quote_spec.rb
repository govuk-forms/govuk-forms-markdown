# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#block_quote" do
  subject(:renderer) { described_class.new }

  it "does not format blockquote (renders as paragraph)" do
    expect(renderer.block_quote("This is a quote").strip).to eq "<p>This is a quote</p>"
  end

  describe "rendering errors" do
    it "does log an error for block quote being used" do
      renderer.block_quote("This is a quote")
      expect(renderer.errors).to eq([:used_block_quote])
    end

    context "when block quote is called multiple times in a single render" do
      it "returns only 1 single warning for that one render" do
        renderer.block_quote("This is a quote")
        renderer.block_quote("This is a quote")

        expect(renderer.errors.length).to eq 1
        expect(renderer.errors).to eq([:used_block_quote])
      end
    end
  end
end
