# frozen_string_literal: true

require "filter/approved_list"

RSpec.describe ApprovedList do
  it "has a list of whitelisted oclcs" do
    expect(ApprovedList.oclcs.count).to be > 0
  end

  it "excludes empties" do
    expect(ApprovedList.oclcs.include?("")).to be false
    expect(ApprovedList.oclcs.include?(0)).to be false
  end

  it "has a list of only integers" do
    ApprovedList.oclcs.each do |o|
      expect(o).to be_an(Integer)
    end
  end
end
