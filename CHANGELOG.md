# CHANGELOG

This file is used to list changes made in changelog reset.

## Unreleased

- Initial creation
- Reads the changelog and searches for a header string of `##`
  - if found it will insert `## Unreleased` above the header string
  - if not found it will insert `## Unreleased` at the end of the file
