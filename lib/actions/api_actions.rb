# frozen_string_literal: true

module Actions
  module ApiActions
    def self.included(base)
      base.class_eval do
        before :register_metadata_strategy
      end
    end

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

    def register_metadata_strategy
      dependencies.set('es.metadata_strategy') do
        Koine::EventSourcing::MetadataStrategy.new do |event|
          metadata = {
            current_user: current_user.uuid,
            remote_ip: request.ip,
          }

          event.with_metadata(metadata)
        end
      end
    end
  end
end
