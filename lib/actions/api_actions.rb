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

    # rubocop:disable Metrics/MethodLength
    def handle_errors
      yield
    rescue Errors::NotFound => error
      body = { message: error.message }
      render(body: body, status: 404)
    rescue ValidationError => error
      body = { message: error.message, errors: error.errors }
      render(body: body, status: 422)
    rescue StandardError => error
      backtrace = error.backtrace.select do |line|
        line.match(Hanami.root.to_s)
      end
      body = { message: error.message, backtrace: backtrace }
      render(body: body, status: 500)
    end

    def register_metadata_strategy
      dependencies.set('es.metadata_strategy') do
        Koine::EventSourcing::MetadataStrategy.new do |event|
          metadata = {
            user_id: current_user.uuid,
            ip_address: request.ip,
          }

          event.with_metadata(metadata)
        end
      end
    end

    def handle_unautorized
      halt 401
    end

    def save_forbidden_url
      session[:redirect_url] = request.url
    end
  end
end
