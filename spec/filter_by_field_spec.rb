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

  it 'can use a normalized field' do
    record = RecordStub.new('author_lccns' =>
                            ['https://lccn.loc.gov/n 50076615 '])
    expect(record.reject_because_of_field?).to be_truthy
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

  it 'can use a normalized publisher' do
    record = RecordStub.new('publisher' =>
                            ['U....S.....   ,GPO; :'])
    expect(record.accept_because_of_field?).to be_truthy
  end
end

RSpec.describe Filter, '#remove_non_word_chars' do
  it 'downcase and strips unnecessary characters' do
    expect(RecordStub.new.remove_non_word_chars('For sale by the Supt. of Docs., Congressional Sales Office, U.S. G.P.O.,')).to eq(['forsalebythesuptofdocscongressionalsalesofficeusgpo'])
  end

  it 'handles unicode' do
    expect(RecordStub.new.remove_non_word_chars('般若心経大成 榛葉元水 編述 23F@20@1')).to eq(['般若心経大成榛葉元水編述23f201'])
  end
end
