require 'filter/blacklist'
list = File.open(ARGV.shift, 'w')
Blacklist.oclcs.each { |o| list.puts o }
