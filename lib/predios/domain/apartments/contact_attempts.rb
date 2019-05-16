# frozen_string_literal: true

module Apartments
  class ContactAttempts
    include Enumerable

    def initialize(attempts)
      @attempts = []
      attempts.each do |attempt|
        add(attempt)
      end
    end

    def each(&block)
      @attempts.each(&block)
    end

    def last
      @attempts.dup.pop
    end

    def add(attempt)
      unless include?(attempt)
        @attempts << attempt
      end

      @attempts = @attempts.sort_by(&:time)
    end

    def include?(attempt)
      map(&:without_precision).include?(attempt.without_precision)
    end
  end
end
