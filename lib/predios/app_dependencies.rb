# frozen_string_literal: true

require 'nurse'

class AppDependencies < Nurse::DependencyContainer
  def initialize
    super

    add_factory(CommandBusFactory.new)

    add_repository('event') do
      EventStoreEventRepository.new
    end
  end

  def repository(name)
    get("repositories.#{name}_repository")
  end

  def service(name)
    get("services.#{name}")
  end

  private

  def add_repository(name, &block)
    share("repositories.#{name}_repository", &block)
  end
end
