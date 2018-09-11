# frozen_string_literal: true

require 'filter'
require 'ostruct'

class RecordStub < OpenStruct
  include Filter
end

RSpec.describe Filter, '#fed_doc?' do
  it 'truthy if it has a u and f' do
    record = RecordStub.new('u_and_f?' => true)
    expect(record.fed_doc?).to be_truthy
  end

  it 'falsey if it has a blacklisted oclc' do
    record = RecordStub.new('oclc_resolved' => [1_454_588])
    expect(record.fed_doc?).to be_falsey
  end

  it 'falsey if it has no reason to be truthy' do
    record = RecordStub.new
    expect(record.fed_doc?).to be_falsey
  end
end
