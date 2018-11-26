# frozen_string_literal: true

module Articles
  module Events
    class ArticleTitleChanged < ArticleEvent
      def new_title
        payload['title']
      end
    end
  end
end
