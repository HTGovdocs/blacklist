# frozen_string_literal: true

require 'filter/gsheet'

class Blacklist < Gsheet
  class << self; attr_accessor :oclcs; end

  def self.sheet_id
    ENV['BLACKLIST_SHEET_ID']
  end

  self.oclcs = get_data.each { |o| o.sub(/^0+/, '') }.reject(&:empty?)
                       .map(&:to_i).to_set
end
