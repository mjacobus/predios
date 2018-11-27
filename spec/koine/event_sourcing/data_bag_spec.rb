# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::DataBag do
  let(:data) { Hash['name' => 'john', last_name: :doe] }
  let(:bag) { described_class.new(data) }

  def collect(bag)
    [].tap do |collection|
      bag.each do |key, value|
        collection.push(key)
        collection.push(value)
      end
    end
  end

  it 'is ennumerable' do
    expect(collect(bag)).to eq(['name', 'john', :last_name, :doe])
  end

  it 'can be stringified' do
    modified = bag.stringify

    expect(modified).to be_a(described_class)
    expect(collect(modified)).to eq(['name', 'john', 'last_name', :doe])
  end

  it 'can be symbolized' do
    modified = bag.symbolize

    expect(modified).to be_a(described_class)
    expect(collect(modified)).to eq([:name, 'john', :last_name, :doe])
  end

  it 'accesses properties as a hash' do
    expect(bag[:last_name]).to be :doe
  end

  it 'fetches properties as a hash' do
    expect(bag.fetch(:last_name)).to be :doe
    expect(bag.fetch(:foo, nil)).to be nil
    expect(bag.fetch(:foo, :bar)).to be :bar
    expect(bag.fetch(:foo) { :bar }).to be :bar

    expect { bag.fetch(:foo) }.to raise_error(KeyError)
  end

  it 'has indifferent access' do
    expect(bag['name']).to eq('john')
    expect(bag[:name]).to eq('john')
    expect(bag[:last_name]).to eq(:doe)
    expect(bag['last_name']).to eq(:doe)
  end

  it 'has indifferent access for key? method' do
    expect(bag).to be_key('name')
    expect(bag).to be_key(:name)
    expect(bag).to be_key(:last_name)
    expect(bag).to be_key('last_name')
    expect(bag).not_to be_key('nops')
  end

  describe '#only' do
    let(:data) { Hash['name' => 'john', last_name: :doe, other: true] }

    it 'returns only the desired attributes' do
      filtered = bag.only(:name, :last_name)

      expect(filtered.to_h).to eq('name' => 'john', last_name: :doe)
    end
  end
end
