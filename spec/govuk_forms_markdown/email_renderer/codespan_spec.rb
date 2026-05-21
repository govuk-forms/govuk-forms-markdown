# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#codespan" do
  subject(:renderer) { described_class.new }

  it "returns the code unchanged" do
    expect(renderer.codespan("code_snippet")).to eq "code_snippet"
  end

  it "logs an error for using codespan" do
    renderer.codespan("code_snippet")
    expect(renderer.errors).to eq([:used_codespan])
  end
end
