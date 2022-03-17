# frozen_string_literal: true

class AuthorityList
  class << self; attr_accessor :lccns; end

  self.lccns = File.open(__dir__ + "/../../data/authority_list.tsv").readlines
    .map { |line| line.chomp.split(/\t/).first }.to_set
end
