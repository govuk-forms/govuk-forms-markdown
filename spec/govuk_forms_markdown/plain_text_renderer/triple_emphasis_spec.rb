# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#triple_emphasis" do
  subject(:renderer) { described_class.new }

  it "does not format triple_emphasis and logs an error" do
    expect(renderer.triple_emphasis("extremely important text")).to eq "extremely important text"
    expect(renderer.errors).to eq([:used_emphasis])
  end
end
