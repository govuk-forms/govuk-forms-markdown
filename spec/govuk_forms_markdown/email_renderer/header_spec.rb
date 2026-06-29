# frozen_string_literal: true

RSpec.describe GovukFormsMarkdown::EmailRenderer, "#header" do
  subject(:renderer) { described_class.new({}, allow_headings:) }

  let(:allow_headings) { true }

  non_supported_heading_levels = [1, 5, 6]
  supported_heading_levels = [2, 3, 4]
  all_heading_levels = non_supported_heading_levels + supported_heading_levels

  context "when using non-supported heading levels" do
    non_supported_heading_levels.each do |level|
      it "does not format heading level #{level}" do
        expect(renderer.header("Heading level #{level}", level).strip).to eq("<p>Heading level #{level}</p>")
      end
    end
  end

  context "when using supported heading levels" do
    it "formats heading level 2" do
      expected = <<~HTML.strip
        <h2 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 27px; line-height: 35px; font-weight: bold; color: #0B0C0C;">
          Heading level 2
        </h2>
      HTML

      expect(renderer.header("Heading level 2", 2).strip).to eq expected
    end

    it "formats heading level 3" do
      expected = <<~HTML.strip
        <h3 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 21px; line-height: 25px; font-weight: bold; color: #0B0C0C;">
          Heading level 3
        </h3>
      HTML

      expect(renderer.header("Heading level 3", 3).strip).to eq expected
    end

    it "formats heading level 4" do
      expected = <<~HTML.strip
        <h4 style="Margin: 0 0 15px 0; padding: 10px 0 0 0; font-size: 19px; line-height: 25px; font-weight: bold; color: #0B0C0C;">
          Heading level 4
        </h4>
      HTML

      expect(renderer.header("Heading level 4", 4).strip).to eq expected
    end
  end

  describe "rendering errors" do
    supported_heading_levels.each do |level|
      it "does not log a warning for heading level #{level}" do
        renderer.header("Heading level #{level}", level)
        expect(renderer.errors).to be_empty
      end
    end

    non_supported_heading_levels.each do |level|
      it "does log a warning for heading level #{level}" do
        renderer.header("Heading level #{level}", level)
        expect(renderer.errors).to eq([:heading_levels])
      end
    end

    context "when header is called multiple times in a single render" do
      it "returns only 1 single warning for that one render" do
        non_supported_heading_levels.each do |level|
          renderer.header("Heading level #{level}", level)
        end

        expect(renderer.errors.length).to eq 1
        expect(renderer.errors).to eq([:heading_levels])
      end
    end

    context "when headings are not allowed" do
      let(:allow_headings) { false }

      all_heading_levels.each do |level|
        it "logs a warning for heading level #{level}" do
          renderer.header("Heading level #{level}", level)
          expect(renderer.errors).to eq([:headings_not_allowed])
        end
      end

      context "when header is called multiple times in a single render" do
        it "returns only 1 single warning for that one render" do
          all_heading_levels.each do |level|
            renderer.header("Heading level #{level}", level)
          end

          expect(renderer.errors.length).to eq 1
          expect(renderer.errors).to eq([:headings_not_allowed])
        end
      end
    end
  end
end
