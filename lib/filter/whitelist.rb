# frozen_string_literal: true

require 'filter/gsheet'

class Whitelist < Gsheet
  class << self; attr_accessor :oclcs; end

  def self.sheet_id
    ENV['WHITELIST_SHEET_ID']
  end

  self.oclcs = get_data.each { |o| o.sub(/^0+/, '') }.reject(&:empty?)
                       .map(&:to_i).to_set
end
