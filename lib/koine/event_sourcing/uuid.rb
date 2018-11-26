# frozen_string_literal: true

module Koine
  module EventSourcing
    class Uuid
      def initialize(value = nil)
        @value = (value || SecureRandom.uuid).dup
        freeze
      end

      def to_s
        @value
      end

      def ==(other)
        other.to_s == to_s
      end
    end
  end
end
