# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#emphasis" do
  subject(:renderer) { described_class.new }

  it "does not format emphasis and logs an error" do
    expect(renderer.emphasis("important text")).to eq "important text"
    expect(renderer.errors).to eq([:used_emphasis])
  end
end
