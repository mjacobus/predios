# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Validators::Base do
  let(:klass) do
    Class.new(described_class) do
      def perform_validation(value, errors)
        if value != 1
          errors.add('Must be 1', field: :number)
        end
      end
    end
  end

  let(:validator) { klass.new }

  describe '#valid?' do
    it 'returns true when value is valid' do
      expect(validator).to be_valid(1)
    end

    it 'returns false when value is not valid' do
      expect(validator).not_to be_valid(0)
    end
  end

  describe '#validate' do
    it 'does not raise when value is valid' do
      expect { validator.validate(1) }.not_to raise_error
    end

    it 'raises eror when value is invalid' do
      expected_errors = Validators::Errors.new.tap do |e|
        e.add('Must be 1', field: :number)
      end

      expect { validator.validate(0) }.to raise_error do |error|
        expect(error).to be_a(Validators::ValidationErrors)
        expect(error.errors).to be_equal_to(expected_errors)
      end
    end
  end
end
