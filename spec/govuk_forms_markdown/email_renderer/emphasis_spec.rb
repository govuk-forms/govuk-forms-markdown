# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#emphasis" do
  subject(:renderer) { described_class.new }

  it "returns the text unchanged" do
    expect(renderer.emphasis("emphasised")).to eq "emphasised"
  end

  it "logs an error for using emphasis" do
    renderer.emphasis("emphasised")
    expect(renderer.errors).to eq([:used_emphasis])
  end
end
