# frozen_string_literal: true

require "filter/rejected_list"

RSpec.describe RejectedList do
  it "has a list of rejected oclcs" do
    expect(RejectedList.oclcs.count).to be > 0
  end

  it "excludes empties" do
    expect(RejectedList.oclcs.include?("")).to be false
    expect(RejectedList.oclcs.include?(0)).to be false
  end

  it "has a list of only integers" do
    RejectedList.oclcs.each do |o|
      expect(o).to be_an(Integer)
    end
  end
end
