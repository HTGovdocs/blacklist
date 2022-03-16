# frozen_string_literal: true

class RejectedList
  class << self; attr_accessor :oclcs; end

  self.oclcs = File.open(__dir__ + "/../../data/rejected_oclc_nums.txt").readlines
    .each { |o| o.sub(/^0+/, "") }.reject(&:empty?).map(&:to_i).to_set
end
