# frozen_string_literal: true

require "pry"

class AuthorityList
  class << self; attr_accessor :lccns; end

  self.lccns = File.open(__dir__ + "/../../data/authority_list.tsv").readlines
    .each { |line| line.chomp.split("\t").first }
end
