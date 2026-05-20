# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#block_quote" do
  subject(:renderer) { described_class.new }

  it "returns the quoted text unmodified" do
    expect(renderer.block_quote("This is a quote")).to eq "This is a quote"
  end

  describe "rendering errors" do
    it "does not log an error for block quote being used" do
      renderer.block_quote("This is a quote")
      expect(renderer.errors).to be_empty
    end
  end
end
