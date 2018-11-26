# frozen_string_literal: true

class TestArticle < Hanami::Entity
  def with_attributes(new_attributes)
    new_attributes = Koine::Utils.hash.symbolize(new_attributes)
    self.class.new(attributes.merge(new_attributes))
  end
end
