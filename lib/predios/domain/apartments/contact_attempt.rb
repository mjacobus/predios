# frozen_string_literal: true

module Apartments
  class ContactAttempt
    attr_reader :time
    attr_reader :outcome
    VALID_OUTCOMES = %w[
      failed
      contacted
    ].freeze

    def initialize(outcome:, time: Time.now)
      unless VALID_OUTCOMES.include?(outcome.to_s)
        raise ArgumentError, 'Invalid outcome'
      end

      @outcome = outcome.to_s
      @time = time.to_time
    end

    def successful?
      @outcome == 'contacted'
    end
  end
end
