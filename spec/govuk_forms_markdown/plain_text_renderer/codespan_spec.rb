# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#codespan" do
  subject(:renderer) { described_class.new }

  it "returns the code and logs an error" do
    expect(renderer.codespan("color: rebeccapurple;")).to eq "color: rebeccapurple;"
    expect(renderer.errors).to eq([:used_codespan])
  end
end
