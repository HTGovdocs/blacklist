# frozen_string_literal: true

require 'filter'
require 'ostruct'

class RecordStub < OpenStruct
  include Filter
end

RSpec.describe Filter, '#reject_because_of_field?' do
  it 'truthy if it has a bad field' do
    record = RecordStub.new('author_lccns' =>
                            ['https://lccn.loc.gov/n50076615'])
    expect(record.reject_because_of_field?).to be_truthy
  end

  it 'falsey if it doesnt' do
    record = RecordStub.new('author_lccns' => ['good_lccn'])
    expect(record.reject_because_of_field?).to be_falsey
  end
end

RSpec.describe Filter, '#accept_because_of_field?' do
  it 'has a marked publisher' do
    record = RecordStub.new('publisher' =>
                            ['Government Printing Office,'])
    expect(record.u_and_f?).to be_falsey
    expect(record.fed_doc?).to be_truthy
    expect(record.accept_because_of_field?).to be_truthy
  end
end
