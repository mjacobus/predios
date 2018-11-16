# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::Uuid do
  it 'when no id is given in the constructor creates a new unique id' do
    expect(SecureRandom).to receive(:uuid).and_return('foobar')

    expect(described_class.new.to_s).to eq 'foobar'
  end

  it 'when id is passed in the constructor uses that value as unique id' do
    string = described_class.new('foo').to_s

    expect(string).to eq 'foo'
  end

  it '#== returns true when values are the same' do
    expect(described_class.new('foo')).to eq described_class.new('foo')
  end

  it '#== returns false when values are different' do
    expect(described_class.new('bar')).not_to eq described_class.new('foo')
  end
end
