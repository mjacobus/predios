# frozen_string_literal: true

module Api
  module Controllers
    module ContactAttempts
      class Destroy < Actions::Api
        private

        def safe_call(params)
          payload = params[:contact_attempts]
          # command = ::Apartments::Commands::AssignContactAttempt.new(payload)
          # execute(command)
          render(status: 201, body: payload)
        end
      end
    end
  end
end

