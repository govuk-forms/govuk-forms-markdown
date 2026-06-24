# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#hrule" do
  subject(:renderer) { described_class.new }

  it "renders three dashes" do
    expect(renderer.hrule).to eq "\n\n---"
    expect(renderer.errors).to be_empty
  end
end
