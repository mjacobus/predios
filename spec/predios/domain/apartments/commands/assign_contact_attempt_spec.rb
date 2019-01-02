# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Commands::AssignContactAttempt do
  let(:payload) do
    {
      'apartment_id' => 'the-uid',
      'outcome' => 'contacted',
      'time' => Time.now,
    }
  end
  let(:command) { described_class.new(payload) }

  describe '#payload' do
    it 'returns the payload with symbol keys' do
      expect(command.payload).to eq symbolize_keys(payload)
    end
  end
end
