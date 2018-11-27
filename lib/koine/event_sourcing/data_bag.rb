# frozen_string_literal: true

module Koine
  module EventSourcing
    class DataBag
      include Enumerable

      def initialize(values)
        @values = values.to_h.freeze
        freeze
      end

      def each(&block)
        @values.each(&block)
      end

      def stringify
        self.class.new(Utils.hash.stringify(@values))
      end

      def symbolize
        self.class.new(Utils.hash.symbolize(@values))
      end

      def [](key)
        if @values.key?(key)
          return @values[key]
        end

        if @values.key?(key.to_sym)
          return @values[key.to_sym]
        end

        if @values.key?(key.to_s)
          return @values[key.to_s]
        end
      end

      def fetch(*args, &block)
        @values.send(:fetch, *args, &block)
      end
    end
  end
end