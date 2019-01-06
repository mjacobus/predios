# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class AssignVisitAttempt < Actions::Api
        private

        def safe_call(params)
          payload = params[:contact_attempt]
          command = ::Apartments::Commands::AssignContactAttempt.new(payload)
          execute(command)
          render(status: 201)
        end
      end
    end
  end
end
