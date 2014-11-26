# Dummy Lexicons

This repository contains a collection of dummy lexicons that can be used during
development/testing by components such as the Property Tagger. These lexicons
were generated based on existing KAF documents and a proprietary set of
lexicons. These dummy lexicons should _only_ contain what is needed for running
automated tests. Due to their tiny size these lexicons are _not_ suitable for
production usage.

## Requirements

* Ruby
* An input KAF document
* A set of existing hotel lexicons.

## Usage

Generating a dummy lexicon for Dutch:

    ./bin/generate.rb ../path/to/proprietary/lexicons/hotel/nl.txt ../path/to/file.nl.kaf > hotel/nl.txt
