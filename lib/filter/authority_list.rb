require 'filter/gsheet'

class AuthorityList < Gsheet
  class << self; attr_accessor :lccns; end

  def self.sheet_id
    ENV['AUTHORITYLIST_SHEET_ID']
  end

  self.lccns = self.get_data.each {|l| l.gsub(/ /,'')}.reject {|l| l.empty?}.to_set
  
end

