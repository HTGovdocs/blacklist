# frozen_string_literal: true

require 'filter/blacklist'
list = File.open(ARGV.shift, 'w')
Blacklist.oclcs.each { |o| list.puts o }
list.close

`scripts/retrieve_deprecated_oclcs.sh`
