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
  end
end

