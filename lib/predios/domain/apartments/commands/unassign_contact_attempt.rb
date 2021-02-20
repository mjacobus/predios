# frozen_string_literal: true

module Apartments
  module Commands
    class UnassignContactAttempt < Command
      ALLOWED_ATTRIBUTES = %i[
        apartment_uuid
        outcome
        time
        type
      ].freeze

      def initialize(payload)
        @payload = DataBag.new(payload).only(ALLOWED_ATTRIBUTES)
      end

      def apartment_uuid
        @payload[:apartment_uuid]
      end

      def outcome
        @payload[:outcome]
      end

      def type
        @payload[:type]
      end

      def time
        @payload[:time]
      end
    end
  end
end
