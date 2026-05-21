# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#hrule" do
  subject(:renderer) { described_class.new }

  it "returns nil for hrule" do
    expect(renderer.hrule).to be_nil
  end

  it "logs an error for using hrule" do
    renderer.hrule
    expect(renderer.errors).to eq([:used_hrule])
  end
end
