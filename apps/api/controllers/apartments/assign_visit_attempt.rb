# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class AssignVisitAttempt
        include Api::Action

        def call(params)
          handle_errors do
            command = ::Apartments::Commands::AssignContactAttempt.new(params[:contact_attempt])
            execute(command)
            render(status: 201)
          end
        end
      end
    end
  end
end
