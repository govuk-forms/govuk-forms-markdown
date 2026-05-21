# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#triple_emphasis" do
  subject(:renderer) { described_class.new }

  it "returns the text unchanged" do
    expect(renderer.triple_emphasis("very strong")).to eq "very strong"
  end

  it "logs an error for using triple_emphasis" do
    renderer.triple_emphasis("very strong")
    expect(renderer.errors).to eq([:used_emphasis])
  end
end
