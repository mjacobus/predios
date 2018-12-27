# frozen_string_literal: true

module Actions
  module ApiActions
    def handle_invalid_csrf_token; end

    private

    def render(body: {}, status: 200)
      self.body = body.to_json
      self.status = status
    end

    def execute(command)
      dependencies.service('command_bus').handle(command)
    end

    def dependencies
      @dependencies ||= AppDependencies.new
    end

    def handle_errors
      yield
    rescue Errors::NotFound => error
      body = { message: error.message }
      render(body: body, status: 404)
    rescue ValidationError => error
      body = { message: error.message, errors: error.errors }
      render(body: body, status: 422)
    rescue StandardError => error
      body = { message: error.message }
      render(body: body, status: 500)
    end
  end
end
