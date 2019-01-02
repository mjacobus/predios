# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::ContactAttempt do
  let(:outcome) { 'contacted' }
  let(:time) { Time.parse('2001-12-01') }
  let(:attempt) { described_class.new(outcome: outcome, time: time) }

  context 'when outcome is contacted' do
    it 'returns true for #successful?' do
      expect(attempt.successful?).to be true
    end
  end

  context 'when contact failed' do
    let(:outcome) { 'failed' }

    it 'returns false for #successful?' do
      expect(attempt.successful?).to be false
    end
  end

  it 'has a proper time' do
    expect(attempt.time).to eq(time)
  end

  it 'raises error when outcome is not whitelisted' do
    expect do
      described_class.new(outcome: 'somethingelse', time: Time.now)
    end.to raise_error(ArgumentError, 'Invalid outcome')
  end
end
