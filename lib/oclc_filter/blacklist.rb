require 'oclc_filter/gsheet'

class Blacklist < Gsheet
  class << self; attr_accessor :oclcs; end

  def self.sheet_id
    ENV['BLACKLIST_SHEET_ID']
  end

  self.oclcs = self.get_data.each {|o| o.sub(/^0+/,'')}.reject {|o| o.empty?}.map(&:to_i).to_set
  
end

