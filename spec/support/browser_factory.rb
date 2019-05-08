# frozen_string_literal: true

class BrowserFactory
  def from_options(options)
    Watir::Browser.new(*options.to_args).tap do |browser|
      browser.cookies.clear
      browser.window.resize_to(375, 667) # iphone
    end
  end
end
