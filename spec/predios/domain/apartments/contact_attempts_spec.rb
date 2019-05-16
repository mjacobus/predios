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
    let(:first_duplicate) do
      Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-02-03 04:05:09')
    )
    end
    let(:second) do
      Apartments::ContactAttempt.new(
      outcome: 'contacted',
      time: Time.parse('2001-02-03 04:05:17'),
      type: 'letter'
    )
    end
    let(:third) do
      Apartments::ContactAttempt.new(
      outcome: 'failed',
      time: Time.parse('2001-02-03 04:06:08')
    )
    end
    let(:third_duplicate) do
      Apartments::ContactAttempt.new(
      outcome: 'failed',
      time: Time.parse('2001-02-03 04:06:02')
    )
    end
    let(:attempts) { described_class.new([second, first, first_duplicate, third, third_duplicate]) }

    it 'removes duplicates' do
      expect(attempts.to_a).to eq([first, second, third])
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
