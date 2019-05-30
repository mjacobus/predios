# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Events::ContactAttemptUnassigned do
  let(:time) { Time.now.utc }
  let(:payload) { Hash[outcome: 'contacted', time: time, type: 'phone'] }
  let(:event_from_db) { described_class.new(JSON.parse(payload.to_json)) }
  let(:event) { described_class.new(payload) }

  it 'handles #time correctly' do
    expect(event.time).to eq(time)
    expect(event_from_db.time).to be_within(1).of(time)
  end

  it 'handles #outcome' do
    expect(event.outcome).to eq('contacted')
    expect(event_from_db.outcome).to eq('contacted')
  end

  it 'handles #type' do
    expect(event.type).to eq('phone')
    expect(event_from_db.type).to eq('phone')
  end

  context 'when type is not given' do
    let(:payload) { Hash[outcome: 'contacted', time: time] }

    it 'defaults to intercom' do
      expect(event.type).to eq('intercom')
    end
  end
end
