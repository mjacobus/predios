# frozen_string_literal: true

module Koine
  module EventSourcing
    class AggregateRoot
      attr_reader :id
      attr_reader :version

      private

      attr_writer :id
    end
  end
end
