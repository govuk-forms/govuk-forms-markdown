# GOV.UK Forms Markdown

This gem is a custom Markdown renderer for the [GOV.UK Forms](https://www.forms.service.gov.uk) apps, designed to render the limited subset of Markdown syntax supported by GOV.UK Forms. It will render:

- Level 2 and 3 headings
- paragraphs
- links
- lists (bullet and numbered)

It will also add the required govuk-frontend classes.

This gem exists largely to handle a GOV.UK Forms service use case and is unlikely to serve other use cases. Consider using these gems instead:

- [govuk-markdown](https://github.com/DFE-Digital/govuk-markdown/) - a more complete Markdown renderer with GOV.UK styles, which includes all standard Markdown syntax plus the ability to create inset text and details components
- [govspeak](https://github.com/alphagov/govspeak) - a powerful Markdown-derived language designed for GOV.UK with many custom extensions
- [redcarpet](https://github.com/vmg/redcarpet) or [Kramdown](https://github.com/gettalong/kramdown) with your own custom configuration, if you need something more bespoke than the above.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Add the gem to your Gemfile:

```ruby
gem "govuk-forms-markdown", require: "govuk_forms_markdown", github: "alphagov/govuk-forms-markdown", tag: "0.8.0" # Check the Github releases for the latest tag
```

Then run `bundle install`.

## Usage

The `render` method will return HTML when provided with a markdown string.

```ruby
# Call the render method with the markdown you want to render
GovukFormsMarkdown.render(markdown)

# You can configure it to disallow headings
GovukFormsMarkdown.render(markdown, allow_headings: false)

# You can configure it if you're passing Welsh language markdown
GovukFormsMarkdown.render(markdown, locale: "cy")
```

The `validate` method will return HTML when provided with a markdown string.

```ruby
# Call the validate method with the markdown you want to render
GovukFormsMarkdown.validate(markdown)

# You can configure it to disallow headings
GovukFormsMarkdown.validate(markdown, allow_headings: false)

# It will return a JSON object containing a list of errors:
{ errors: [:too_long, :unsupported_tags_used] }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Releasing a new version

1. Update the version number in `version.rb`
2. Run `bundle install` to update the Gemfile.lock with the new version number
3. Edit the `CHANGELOG.md` file to add a section for the new version
4. Create a PR to merge these changes
5. Create a [release](https://github.com/govuk-forms/govuk-forms-markdown/releases) on GitHub. Select "Create new tag" to create a tag with the version number. Click the "Generate release notes" button, and edit the generated notes to separate out the dependency updates from the changes we've made.

## Contributing

We welcome contributions - please read [CONTRIBUTING.md](CONTRIBUTING.md) and the [alphagov Code of Conduct](https://github.com/alphagov/.github/blob/main/CODE_OF_CONDUCT.md) before contributing.

## License

We use the [MIT License](https://opensource.org/licenses/MIT).
