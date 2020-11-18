# CHANGELOG

This file is used to list changes made in changelog reset.

## 1.0.2 - *2020-11-18*

- Fixed bug with dockerhub push due to set-env deprecation

## 1.0.1 - *2020-10-25*

- Fixed bug with startup logic

## 1.0.0 - *2020-10-25*

- Initial creation
- Reads the changelog and searches for a header string of `##`
  - if found it will insert `## 1.0.0 - *2020-10-25*` above the header string
  - if not found it will insert `## 1.0.0 - *2020-10-25*` at the end of the file
