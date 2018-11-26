# frozen_string_literal: true

class TestDependencies < AppDependencies
  def initialize
    super

    define('repositories.article_repository') do
      TestArticleRepository.new
    end
  end
end
