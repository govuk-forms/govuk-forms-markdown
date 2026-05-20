# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#hrule" do
  subject(:renderer) { described_class.new }

  it "does not render hrule and logs an error" do
    expect(renderer.hrule).to be_nil
    expect(renderer.errors).to eq([:used_hrule])
  end
end
