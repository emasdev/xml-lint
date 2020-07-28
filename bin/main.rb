# frozen_string_literal: true

require_relative '../lib/xml_lint.rb'
# rubocop:disable Style/MixinUsage
include XMLlint
# rubocop:enable Style/MixinUsage

ARGV.each do |file_name|
  xml_file = File.open("./docs/#{file_name}")
  xml = xml_file.read
  puts "\n=== linter #{file_name} ==="
  xml.xml_lint
end
