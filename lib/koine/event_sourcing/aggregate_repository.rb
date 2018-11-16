# frozen_string_literal: true

module Koine
  module EventSourcing
    class AggregateRepository
      def initialize(event_store:, aggregate_type:); end

      def find; end
    end
  end
end
