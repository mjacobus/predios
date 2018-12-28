# frozen_string_literal: true

module Koine
  module EventSourcing
    class NullMetadataStrategy
      def with_metadata(event)
        event
      end
    end
  end
end
