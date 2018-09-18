# frozen_string_literal: true

require 'filter/gsheet'

class AuthorityList < Gsheet
  class << self; attr_accessor :lccns; end

  def self.sheet_id
    ENV['AUTHORITYLIST_SHEET_ID']
  end

  self.lccns = get_data('All Authorities').each { |l| l.delete!(' ') }
                                          .reject(&:empty?).to_set
end
