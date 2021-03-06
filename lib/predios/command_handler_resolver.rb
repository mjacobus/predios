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
    prefix = 'command_handlers'

    if path.split('/')[1] == 'queries'
      prefix = 'query_handlers'
    end

    path = path.sub('/commands/', '.').sub('/queries/', '.').tr('/', '.')
    key = "#{prefix}.#{path}"

    if @dependencies.defined?(key)
      @dependencies.get(key)
    end
  end

  def from_constant(command)
    handler_class = command.class.to_s
      .sub('Commands', 'CommandHandlers')
      .sub('Queries', 'QueryHandlers')

    if Object.const_defined?(handler_class)
      Object.const_get(handler_class).new
    end
  end
end
