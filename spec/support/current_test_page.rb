# frozen_string_literal: true

class CurrentTestPage
  attr_reader :browser

  def initialize(browser)
    @browser = browser
  end

  def has_content?(content, wait: 5)
    if wait
      return wait_until(timeout: wait) do
        has_content?(content, wait: nil)
      end
    end

    text.include?(content)
  rescue Watir::Wait::TimeoutError => _error
    false
  end

  def has_no_content?(content, wait: 5)
    if wait
      return wait_until(timeout: wait) do
        has_no_content?(content, wait: nil)
      end
    end

    text.include?(content) == false
  rescue Watir::Wait::TimeoutError => _error
    false
  end

  def text
    browser.text
  end

  def has_element?(options = {})
    browser.element(options).wait_until(&:present?).present?
  rescue Watir::Wait::TimeoutError => _error
    false
  end

  def has_no_element?(options = {})
    wait_until { browser.element(options).present? == false }
  rescue Watir::Wait::TimeoutError => _error
    false
  end

  def wait_until(*args, &block)
    Watir::Wait.until(*args, &block)
  end
end
