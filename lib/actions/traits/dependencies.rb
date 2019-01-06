# frozen_string_literal: true

module Actions
  module Traits
    module Dependencies
      private

      def dependencies
        @dependencies ||= AppDependencies.new
      end
    end
  end
end
