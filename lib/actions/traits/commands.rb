# frozen_string_literal: true

module Actions
  module Traits
    module Commands
      def self.included(base)
        base.class_eval do
          before :register_metadata_strategy
        end
      end

      private

      def register_metadata_strategy
        dependencies.set('es.metadata_strategy') do
          Koine::EventSourcing::MetadataStrategy.new do |event|
            metadata = {
              user_id: current_user.uuid,
              ip_address: request.ip,
            }

            event.with_metadata(metadata)
          end
        end
      end

      def execute(command)
        dependencies.service('command_bus').handle(command)
      end
    end
  end
end
