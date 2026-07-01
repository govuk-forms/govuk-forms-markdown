# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::PlainTextRenderer, "#linebreak" do
  subject(:renderer) { described_class.new }

  it "renders a linebreak as a plain text newline" do
    expect(renderer.linebreak).to eq "\n"
  end
end
