# frozen_string_literal: true

module Apartments
  module Commands
    class AssignContactAttempt < Command
      ALLOWED_ATTRIBUTES = %i[
        apartment_id
        outcome
        time
      ].freeze

      def initialize(payload)
        @payload = DataBag.new(payload).only(ALLOWED_ATTRIBUTES)
      end

      def payload
        @payload.symbolize.to_h
      end
    end
  end
end
