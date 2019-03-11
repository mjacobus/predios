# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Validators::Errors do
  let(:errors) { described_class.new }

  it 'is initially empty' do
    expect(errors).to be_empty
  end

  describe '#to_h' do
    before do
      errors.add('Some message')
      errors.add('Some message again')
      errors.add('Taken', field: 'username')
    end

    it 'displays all the error messages' do
      expect(errors.to_h).to eq(
        general_errors: [
          'Some message',
          'Some message again',
        ],
        username: ['Taken']
      )
    end

    it 'is not empty' do
      expect(errors).not_to be_empty
    end

    it 'can be cleared' do
      errors.clear

      expect(errors).to be_empty
    end
  end
end
