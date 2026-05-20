# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#double_emphasis" do
  subject(:renderer) { described_class.new }

  it "does not format double_emphasis and logs an error" do
    expect(renderer.double_emphasis("very important text")).to eq "very important text"
    expect(renderer.errors).to eq([:used_emphasis])
  end
end
