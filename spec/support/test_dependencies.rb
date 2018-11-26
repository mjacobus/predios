# frozen_string_literal: true

class TestDependencies < AppDependencies
  def initialize
    super

    add_repository('article') { TestArticleRepository.new }
  end
end
