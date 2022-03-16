# frozen_string_literal: true

require "filter/authority_list"
require "pry"

RSpec.describe AuthorityList do
  it "has a list of white listed authorities" do
    expect(AuthorityList.lccns.count).to be > 0
  end

  it "excludes empties" do
    expect(AuthorityList.lccns.include?("")).to be false
    expect(AuthorityList.lccns.include?(0)).to be false
  end

  it "has a list of only uris" do
    AuthorityList.lccns.each do |lccn|
      expect(lccn).to match(/^http/)
    end
  end
end
