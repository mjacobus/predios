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
    end.to raise_error(ArgumentError, "Invalid outcome 'somethingelse'")
  end

  it 'raises error when type is not whitelisted' do
    expect do
      described_class.new(type: 'somethingelse', outcome: 'failed', time: Time.now)
    end.to raise_error(ArgumentError, "Invalid contact type 'somethingelse'")
  end

  describe '#without_precision' do
    let(:failed_one) do
      described_class.new(
        outcome: 'failed',
        time: Time.parse('2001-01-02 04:05:06')
      )
    end
    let(:same_time_contacted) do
      described_class.new(
        outcome: 'contacted',
        time: Time.parse('2001-01-02 04:05:06')
      )
    end
    let(:same_failure) do
      described_class.new(
        outcome: 'failed',
        time: Time.parse('2001-01-02 04:05:07')
      )
    end
    let(:other_failure) do
      described_class.new(
        outcome: 'failed',
        time: Time.parse('2001-01-02 04:06:07')
      )
    end

    it 'will be considered the same if they belong the same minute' do
      expect(failed_one).not_to eq(same_failure)
      expect(failed_one).not_to eq(other_failure)
      expect(failed_one.without_precision).to eq(same_failure.without_precision)
      expect(failed_one.without_precision).not_to eq(other_failure.without_precision)

      expect(failed_one).not_to eq(same_time_contacted)
      expect(failed_one.without_precision)
        .not_to eq(same_time_contacted.without_precision)
    end
  end
end
