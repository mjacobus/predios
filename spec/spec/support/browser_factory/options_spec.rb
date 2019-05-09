# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrowserFactory::Options do
  describe '#headless' do
    it 'defaults to false' do
      options = from_cli('--foo')

      expect(options).not_to be_headless
    end

    it 'can be set to true' do
      options = from_cli('--foo --headless --bar')

      expect(options).to be_headless
    end
  end

  describe '#browser' do
    it 'defaults to :chrome' do
      options = from_cli

      expect(options.browser).to be(:chrome)
    end

    it 'can be set to :firefox' do
      options = from_cli('--browser=firefox')

      expect(options.browser).to be(:firefox)
    end
  end

  describe '#to_args' do
    it 'converts to args' do
      args = from_cli.to_args

      expect(args).to eq([:chrome, headless: false])
    end
  end

  def from_cli(string = '--foo --bar')
    described_class.from_cli_options(string)
  end
end
