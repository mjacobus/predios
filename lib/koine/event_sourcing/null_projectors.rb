# frozen_string_literal: true

module Koine
  module EventSourcing
    class NullProjectors
      def project(events); end
    end
  end
end
