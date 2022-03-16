# frozen_string_literal: true

class ApprovedList
  class << self; attr_accessor :oclcs; end

  self.oclcs = File.open("data/approved_oclc_nums.txt").readlines
    .each { |o| o.sub(/^0+/, "") }.reject(&:empty?).map(&:to_i).to_set
end
