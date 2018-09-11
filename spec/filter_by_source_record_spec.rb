# frozen_string_literal: true

require 'filter'
require 'ostruct'

class RecordStub < OpenStruct
  include Filter
end

RSpec.describe Filter do
  it 'reject_source_record? if it has a bad org and id' do
    record = RecordStub.new('org_code' => 'miaahdl', 'local_id' => '010085562')
    expect(record.reject_source_record?).to be_truthy
  end
end
