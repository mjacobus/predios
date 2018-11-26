# frozen_string_literal: true

require 'nurse'

class AppDependencies < Nurse::DependencyContainer
  def initialize
    super

    add_factory(CommandBusFactory.new)
  end
end
