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

RSpec.describe Filter, '#rejected?' do
  it 'returns true if OCN is in blacklist' do
    record = RecordStub.new('oclc_resolved' => [1_454_588])
    expect(record.rejected?).to be_truthy
  end

  it 'returns true if it has a bad field' do
    record = RecordStub.new('author_lccns' =>
                            ['https://lccn.loc.gov/n50076615'])
    expect(record.rejected?).to be_truthy
  end

  it 'returns true if it is a bad source record' do
    record = RecordStub.new('org_code' => 'miaahdl', 'local_id' => '010085562')
    expect(record.rejected?).to be_truthy
  end
end
