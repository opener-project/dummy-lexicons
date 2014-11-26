#!/usr/bin/env ruby

require 'oga'
require 'slop'

parser = Slop.new(:strict => true, :help => true, :indent => 2) do
  banner 'Usage: generate.rb [INPUT-MODEL] [INPUT-KAF]'

  separator <<-EOF.chomp

About:

    Generates a dummy lexicon that can be used by components such as the
    property tagger. The resulting lexicon only contains the properties
    mentioned in the given KAF document.

    The generated lexicons are not suitable for production use due to them only
    containing a very small set of entries. Instead they are meant for testing
    and development purposes

Example:

    generate.rb path/to/models/hotel/en.txt path/to/output.en.kaf
  EOF

  separator "\nOptions:\n"

  run do |opts, args|
    abort self.to_s unless args.length == 2

    input_model, input_kaf = args

    document      = Oga.parse_xml(File.open(input_kaf, 'r'))
    input_mapping = {}

    File.open(input_model, 'r') do |handle|
      handle.each_line do |line|
        words, type, category = line.strip.split("\t")

        input_mapping[words] = {:type => type, :category => category}
      end
    end

    document.xpath('KAF/features/properties/property').each do |property|
      property.xpath('references/span/target').each do |target|
        tid  = target.get('id')
        term = document.at_xpath('KAF/terms/term[@tid=$tid]', 'tid' => tid)

        words    = term.get('lemma').downcase
        type     = input_mapping[words][:type]
        category = input_mapping[words][:category]

        puts "#{words}\t#{type}\t#{category}"
      end
    end
  end
end

parser.parse
