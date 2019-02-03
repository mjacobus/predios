# frozen_string_literal: true

module Apartments
  class ContactAttempts
    include Enumerable

    def initialize(attempts)
      @attempts = []
      attempts.sort_by(&:time).each do |attempt|
        unless include?(attempt)
          @attempts << attempt
        end
      end
    end

    def each(&block)
      @attempts.each(&block)
    end

    def last
      @attempts.dup.pop
    end

    private

    def include?(attempt)
      map(&:without_precision).include?(attempt.without_precision)
    end
  end
end
