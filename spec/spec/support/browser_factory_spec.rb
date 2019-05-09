# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrowserFactory do
  let(:factory) { described_class.new }

  describe '.from_options' do
    let(:args) { [:chrome, foo: :bar] }
    let(:options) { instance_double(BrowserFactory::Options, to_args: args) }
    let(:cookies) { Hash[foo: :bar] }
    let(:browser) { instance_double(Watir::Browser, cookies: cookies) }
    let(:window) { double(:window) }

    before do
      allow(Watir::Browser)
        .to receive(:new)
        .with(:chrome, foo: :bar)
        .and_return(browser)

      allow(browser)
        .to receive(:window)
        .and_return(window)

      expect(window).to receive(:resize_to).with(375, 667)
    end

    it 'creates from options and clears cookies' do
      product = factory.from_options(options)

      expect(product).to be(browser)
      expect(cookies).to eq({})
    end
  end
end
