# frozen_string_literal: true

module Koine
  module Utils
    class Hash
      def deep_symbolize(hash)
        Hanami::Utils::Hash.deep_symbolize(hash)
      end

      def shallow_symbolize(hash)
        Hanami::Utils::Hash.symbolize(hash)
      end

      def symbolize(hash, deep: true)
        if deep
          return deep_symbolize(hash)
        end

        shallow_symbolize(hash)
      end

      def deep_stringify(hash)
        Hanami::Utils::Hash.deep_stringify(hash)
      end

      def shallow_stringify(hash)
        Hanami::Utils::Hash.symbolize(hash)
      end

      def stringify(hash, deep: true)
        if deep
          return deep_stringify(hash)
        end

        shallow_stringify(hash)
      end
    end
  end
end
