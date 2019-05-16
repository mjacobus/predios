# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::ContactAttempts do
  it 'sorts by time' do
    first = Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-01-02 04:05:06')
    )
    last = Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-01-02 04:07:07')
    )

    attempts = described_class.new([last, first])

    expect(attempts.to_a).to eq([first, last])
  end

  context 'when there are duplicates in the same minute' do
    let(:first) do
      Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-02-03 04:05:06')
    )
    end
    let(:second) do
      Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-02-03 04:05:07'),
      type: 'letter'
    )
    end
    let(:duplicate1) do
      Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-02-03 04:05:09')
    )
    end
    let(:last) do
      Apartments::ContactAttempt.new(
      outcome: 'failed',
      time: Time.parse('2001-02-03 04:05:08')
    )
    end
    let(:duplicate2) do
      Apartments::ContactAttempt.new(
      outcome: 'failed',
      time: Time.parse('2001-02-03 04:05:08')
    )
    end
    let(:attempts) { described_class.new([first, second, duplicate1, duplicate2, last]) }

    it 'removes duplicates' do
      expect(attempts.to_a.size).to eq(3)
      expect(attempts.to_a[0]).to eq(first)
      expect(attempts.to_a[1]).to eq(second)
      expect(attempts.to_a[2]).to eq(last)
      expect(attempts.to_a).to eq([first, second, last])
    end
  end

  it 'has a #last method' do
    first = Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-01-02 04:05:06')
    )
    last = Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-01-02 04:07:07')
    )

    attempts = described_class.new([last, first])

    expect(attempts.last).to be last
    expect(attempts.last).to be last
  end
end
