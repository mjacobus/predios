# frozen_string_literal: true

module FeatureHelpers
  def self.included(base)
    base.class_eval do
      let(:browser_options) do
        string = ENV.fetch('BROWSER_OPTIONS', '--headless').split('|').join(' ')
        BrowserFactory::Options.from_cli_options(string)
      end

      let(:browser) { BrowserFactory.new.from_options(browser_options) }
      let(:page) { CurrentTestPage.new(browser) }

      after do
        browser.close
        clear_all
      end
    end
  end

  def url(path = '/')
    "http://localhost:4000#{path}"
  end

  def visit(path)
    browser.goto(url(path))
  end

  def login_as_master
    user = create_user do |u|
      u.as_master.enable
    end

    login_as(user)
  end

  def login
    login_as(create_user {})
  end

  def login_as(user)
    visit("/dev/login?user_id=#{user.id}")
    visit('/buildings')
  end

  def click_menu(item)
    browser.button(class: 'navbar-toggle').click
    browser.link(text: item).click
  end

  def fill_in(name = nil, options = {})
    with = options.fetch(:with)
    options.delete(:with)

    if name
      options[:name] = name.to_s
    end

    browser.text_field(options).set(with)
  end

  def select(value, from: nil)
    if from
      element = browser.select_list(name: from.to_s)
    end

    element.select(value)
  end

  def click_on(text)
    browser.element(text: text).click
  end

  def click_button(text)
    browser.button(text: text).click
  end

  def create_user
    args = {
      name: 'John Doe',
      email: 'jon@doe.com',
      oauth_provider: 'google',
      oauth_uid: 'someid',
      enabled: true,
    }

    user = User.new(args)

    if block_given?
      user = yield(user)
    end

    UserRepository.new.create(user)
  end
end
