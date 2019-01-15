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

      def key?(key)
        @values.key?(key) || @values.key?(key.to_s) || @values.key?(key.to_sym)
      end

      def only(*keys)
        keys = keys.flatten.map { |key| [key.to_s, key.to_sym] }.flatten.uniq
        data = @values.select do |key, _value|
          keys.include?(key)
        end
        self.class.new(data)
      end

      def empty_to_nil
        filtered = {}

        each do |attr, value|
          if value.is_a?(String) && value.strip.empty?
            value = nil
          end

          filtered[attr] = value
        end

        self.class.new(filtered)
      end

      def compact
        self.class.new(@values.compact)
      end
    end
  end
end
