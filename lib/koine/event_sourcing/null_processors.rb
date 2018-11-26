# frozen_string_literal: true

module Koine
  module EventSourcing
    class NullProcessors
      def process(events); end
    end
  end
end
