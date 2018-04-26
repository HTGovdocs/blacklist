require 'filter/whitelist'
require 'dotenv'

Dotenv.load

RSpec.describe Whitelist do
  it 'has the remote resource' do
    expect(Whitelist.sheet_id).to be_truthy
  end

  it 'has a list of whitelisted oclcs' do
    expect(Whitelist.oclcs.count).to be > 0
  end

  it 'excludes empties' do
    expect(Whitelist.oclcs.include?('')).to be false
    expect(Whitelist.oclcs.include?(0)).to be false
  end

  it 'has a list of only integers' do
    Whitelist.oclcs.each do |o|
      expect(o).to be_an(Integer)
    end
  end
end
