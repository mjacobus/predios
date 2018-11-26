# frozen_string_literal: true

module Articles
  module Events
    class ArticleBodyChanged < ArticleEvent
      def new_body
        payload['body']
      end
    end
  end
end
