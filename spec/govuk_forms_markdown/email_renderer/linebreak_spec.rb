# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#linebreak" do
  subject(:renderer) { described_class.new }

  it "renders a linebreak as a HTML linebreak" do
    expected = <<~HTML.strip
      <br/>
    HTML
    expect(renderer.linebreak.strip).to eq expected
  end
end
