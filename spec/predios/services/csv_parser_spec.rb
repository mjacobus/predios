# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CsvParser do
  let(:filename) { "#{FIXTURES_PATH}/sample.csv" }
  let(:result) { described_class.new.parse_file(filename) }

  it 'parses file' do
    expect(result.length).to eq(2)

    expect(result[0][:number]).to eq(1.to_s)
    expect(result[1][:number]).to eq(2.to_s)

    expect(result[0][:address]).to eq('Address 1, 1')
    expect(result[1][:address]).to eq('Address 2, 2')
  end

  it 'raises when file does not exist' do
    expect { described_class.new.parse_file('foo') }.to raise_error(Errno::ENOENT)
  end
end
