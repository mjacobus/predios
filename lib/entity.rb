# frozen_string_literal: true

class Entity < Hanami::Entity
  class << self
    private

    def mutator_for(attribute_name)
      define_method "with_#{attribute_name}" do |value|
        with_attribute(attribute_name, value)
      end
    end
  end

  private

  def with_attribute(attribute_name, value)
    self.class.new(attributes.merge(attribute_name => value))
  end
end
