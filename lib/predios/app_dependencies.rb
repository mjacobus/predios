# frozen_string_literal: true

require 'nurse'

class AppDependencies < Nurse::DependencyContainer
  def initialize
    super

    add_factory(CommandBusFactory.new)
  end

  def repository(name)
    get("repositories.#{name}_repository")
  end

  def service(name)
    get("services.#{name}")
  end
end
