# frozen_string_literal: true

require 'service_factory'

class CommandBusFactory < ServiceFactory
  key 'services.command_bus'

  def create_service(container)
    resolver = CommandHandlerResolver.new(dependencies: container)
    CommandBus.new([resolver])
  end
end
