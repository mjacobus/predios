# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Filters::BuildingCsvRowFilter do
  let(:filtered) { described_class.new.filter(row) }
  let(:data) { { 'name' => 'the-name' }.merge(key => value) }
  let(:row) { DataBag.new(data) }
  let(:key) { 'any-key' }
  let(:value) { 'any-value' }

  describe 'individual mail boxes' do
    let(:key) { :letters }

    it 'preserves other attributes' do
      expect(filtered[:name]).to eq 'the-name'
    end

    context 'when value is an "X"' do
      let(:value) { 'X' }

      it 'sets individual mail boxes to true' do
        expect(filtered[:has_individual_letterboxes]).to be true
      end
    end

    context 'when value is an ""' do
      let(:value) { '' }

      it 'sets individual mail boxes to true' do
        expect(filtered[:has_individual_letterboxes]).to be false
      end
    end

    context 'when value is an nil' do
      let(:value) { nil }

      it 'sets individual mail boxes to true' do
        expect(filtered[:has_individual_letterboxes]).to be false
      end
    end
  end

  describe 'individual mail intercoms' do
    let(:key) { :intercoms }

    it 'preserves other attributes' do
      expect(filtered[:name]).to eq 'the-name'
    end

    context 'when value is an "X"' do
      let(:value) { 'X' }

      it 'sets individual intercoms to true' do
        expect(filtered[:has_individual_intercoms]).to be true
      end
    end

    context 'when value is an ""' do
      let(:value) { '' }

      it 'sets individual intercoms to true' do
        expect(filtered[:has_individual_intercoms]).to be false
      end
    end

    context 'when value is an nil' do
      let(:value) { nil }

      it 'sets individual intercoms to true' do
        expect(filtered[:has_individual_intercoms]).to be false
      end
    end
  end
end
