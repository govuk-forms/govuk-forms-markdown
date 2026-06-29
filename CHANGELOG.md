## [Unreleased]

## Released

### [0.11.0] - 2026-06-29

- Update type scale to preserve heading hierarchy [#98](https://github.com/alphagov/govuk-forms-markdown/pull/98)
- Dependency updates

### [0.10.0] - 2026-06-16

- Add support for additional email formatting [#93](https://github.com/alphagov/govuk-forms-markdown/pull/93)
- Dependency updates

### [0.9.0] - 2026-05-26

- Add method to format markdown as plain text [#84](https://github.com/alphagov/govuk-forms-markdown/pull/84)
- Add method to format markdown as HTML for use in emails [#85](https://github.com/alphagov/govuk-forms-markdown/pull/85)
- Dependency updates

### [0.8.0] - 2026-03-05

- Make gem locale aware and add localised new tab text [#65](https://github.com/alphagov/govuk-forms-markdown/pull/65)
- Dependency updates

### [0.7.0] - 2026-02-13

- Add lockfile checksums [#45](https://github.com/alphagov/govuk-forms-markdown/pull/45)
- Dependency updates

### [0.6.0] - 2025-06-10

- Add .DS_Store files to .gitignore [#20](https://github.com/alphagov/govuk-forms-markdown/pull/20)
- Create dependabot.yml [#24](https://github.com/alphagov/govuk-forms-markdown/pull/24)
- Schedule dependabot updates every Sunday [#31](https://github.com/alphagov/govuk-forms-markdown/pull/31)
- Normalize platforms in Bundler lockfile [#29](https://github.com/alphagov/govuk-forms-markdown/pull/29)
- Bump supported minimum version of Ruby to 3.4.1 [#30](https://github.com/alphagov/govuk-forms-markdown/pull/30)
- Dependency updates

### [0.5.0] - 2023-12-18

- Add `(opens in new tab)` suffix to link text [#13](https://github.com/alphagov/govuk-forms-markdown/pull/18)

### [0.4.0] - 2023-11-24

- Let users configure whether headings are allowed [#17](https://github.com/alphagov/govuk-forms-markdown/pull/17)

### [0.3.1] - 2023-09-22

- Disallow indented code blocks [#15](https://github.com/alphagov/govuk-forms-markdown/pull/15)

### [0.3.0] - 2023-08-30

- Add a Validator check if markdown is not too long or using unsupported markdown syntax [#13](https://github.com/alphagov/govuk-forms-markdown/pull/13)

### [0.2.1] - 2023-08-21

- Bump heading sizes down a level [#12](https://github.com/alphagov/govuk-forms-markdown/pull/12/)

### [0.2.0] - 2023-08-015

- All links should open in a new tab [#9](https://github.com/alphagov/govuk-forms-markdown/issues/9)

### [0.1.0] - 2023-08-03

- Initial release
- Adds custom render methods for markdown syntax we would like to support.
  - Heading levels 2 & 3, anything else returns as unstyled text
  - Links styled like GOV.UK
  - Lists (ordered and unordered)

- We do not support the following
  - Heading level 1
  - tables
  - horizontal rules
  - emphasis
  - code blocks
  - custom HTML
