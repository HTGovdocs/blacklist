# frozen_string_literal: true

require "filter/rejected_list"
list = File.open(ARGV.shift, "w")
RejectedList.oclcs.each { |o| list.puts o }
list.close

`scripts/retrieve_deprecated_oclcs.sh`
