# frozen_string_literal: true

module Koine
  module EventSourcing
    class NullProjections
      def project(events); end
    end
  end
end
