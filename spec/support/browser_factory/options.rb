# frozen_string_literal: true

class BrowserFactory
  class Options
    def initialize(attrs)
      @attrs = attrs
    end

    def browser
      @attrs.fetch(:browser)
    end

    # zombie_scout ignore
    def headless?
      @attrs.fetch(:headless)
    end

    def to_args
      attrs = @attrs.dup
      browser = attrs.delete(:browser)
      [browser, attrs]
    end

    class << self
      # zombie_scout ignore
      def from_cli_options(string)
        options = string.split(' ')

        args = {
          headless: false,
          browser: :chrome,
        }

        if options.include?('--headless')
          args[:headless] = true
        end

        if find_option('browser', options)
          args[:browser] = find_option('browser', options).to_sym
        end

        new(args)
      end

      private

      def find_option(option_name, options)
        option = options.find { |o| o.to_s.match("--#{option_name}") }

        unless option
          return
        end

        option.split('=').last
      end
    end
  end
end
