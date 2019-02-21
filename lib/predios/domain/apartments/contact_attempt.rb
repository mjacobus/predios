# frozen_string_literal: true

module Apartments
  class ContactAttempt
    attr_reader :time
    attr_reader :outcome
    attr_reader :type

    VALID_OUTCOMES = %w[
      failed
      contacted
    ].freeze

    VALID_TYPES = %w[
      intercom
      phone
      letter
    ].freeze

    def initialize(outcome:, time: Time.now, type: 'intercom')
      unless VALID_OUTCOMES.include?(outcome.to_s)
        raise ArgumentError, "Invalid outcome '#{outcome}'"
      end

      unless VALID_TYPES.include?(type.to_s)
        raise ArgumentError, "Invalid contact type '#{type}'"
      end

      @outcome = outcome.to_s
      @type = type.to_s
      @time = time.to_time.utc
    end

    def successful?
      @outcome == 'contacted'
    end

    def without_precision
      time_without_precision = Time.new(
        time.year,
        time.month,
        time.day,
        time.hour,
        time.min
      )
      self.class.new(outcome: outcome, time: time_without_precision)
    end

    def ==(other)
      other.outcome == outcome && other.time == time
    end
  end
end
