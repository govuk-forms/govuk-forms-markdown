# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#hrule" do
  subject(:renderer) { described_class.new }

  it "returns a styled horizontal rule" do
    expect(renderer.hrule).to eq "<hr style=\"border: 0; height: 1px; background: #B1B4B6; Margin: 30px 0 30px 0;\">\n"
  end

  it "does not log an error for using hrule" do
    renderer.hrule
    expect(renderer.errors).to be_empty
  end
end
