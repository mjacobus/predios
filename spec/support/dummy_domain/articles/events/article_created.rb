# frozen_string_literal: true

module Articles
  module Events
    class ArticleCreated < ArticleEvent
      def id
        payload['id']
      end

      def title
        payload['title']
      end

      def body
        payload['body']
      end
    end
  end
end
