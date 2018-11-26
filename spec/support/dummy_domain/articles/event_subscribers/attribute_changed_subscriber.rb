# frozen_string_literal: true

module Articles
  module EventSubscribers
    class AttributeChangedSubscriber
      def initialize(repository:)
        @repository = repository
      end

      def publish(event)
        article = @repository.by_uuid(event.aggregate_id)
        new_attributes = event.payload.dup
        new_attributes.delete(:id)
        changed = article.with_attributes(new_attributes)
        @repository.save(changed)
      end
    end
  end
end
