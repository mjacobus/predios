# frozen_string_literal: true

module Koine
  module EventSourcing
    class MetadataStrategy
      def initialize(&block)
        @block = block
      end

      def with_metadata(event)
        @block.call(event)
      end
    end
  end
end
