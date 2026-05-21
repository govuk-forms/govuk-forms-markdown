# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#double_emphasis" do
  subject(:renderer) { described_class.new }

  it "returns the text unchanged" do
    expect(renderer.double_emphasis("strong")).to eq "strong"
  end

  it "logs an error for using double_emphasis" do
    renderer.double_emphasis("strong")
    expect(renderer.errors).to eq([:used_emphasis])
  end
end
