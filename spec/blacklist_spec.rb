require 'blacklist'
require 'dotenv'

Dotenv.load

RSpec.describe Blacklist do
  it "has the remote resource" do
    expect(Blacklist.blacklist_sheet_id).to be_truthy
  end

  it "has a list of blacklisted oclcs" do
    expect(Blacklist.oclcs.count).to be > 10 
  end

  it "excludes empties" do
    expect(Blacklist.oclcs.include? "").to be false
    expect(Blacklist.oclcs.include? 0).to be false
  end

  it "has a list of only integers" do
    Blacklist.oclcs.each do | o |
      expect(o).to be_an(Integer)
    end
  end
end

