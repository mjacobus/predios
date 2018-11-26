# frozen_string_literal: true

class CommandHandlerResolver
  def initialize(dependencies:)
    @dependencies = dependencies
  end

  def resolve(command)
    from_dependencies(command) || from_constant(command)
  end

  private

  def from_dependencies(command)
    path = Hanami::Utils::String.underscore(command.class.to_s)
    path = path.sub('/commands/', '.').tr('/', '.')
    key = "command_handlers.#{path}"

    if @dependencies.defined?(key)
      @dependencies.get(key)
    end
  end

  def from_constant(command)
    handler_class = command.class.sub('Commands', 'CommandHandlers')

    if Object.const_defined?(handler_class)
      Object.const_get(handler_class).new
    end
  end
end
