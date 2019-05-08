# frozen_string_literal: true

module FeatureHelpers
  def self.included(base)
    base.class_eval do
      let(:browser_options) do
        string = ENV.fetch('BROWSER_OPTIONS', '--headless').split('|').join(' ')
        BrowserFactory::Options.from_cli_options(string)
      end

      let(:browser) do
        BrowserFactory.new.from_options(browser_options)
      end

      after do
        browser.close
      end
    end
  end

  def url(path = '/')
    "http://localhost:4000#{path}"
  end
end
