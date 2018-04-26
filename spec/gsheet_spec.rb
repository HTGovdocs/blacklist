require 'filter/gsheet'
require 'dotenv'
require 'pp'

Dotenv.load!

RSpec.describe Gsheet do
  it 'can get credentials' do
    expect(Gsheet.authorize.scope[0]).to eq('https://www.googleapis.com/auth/spreadsheets.readonly')
  end
end
