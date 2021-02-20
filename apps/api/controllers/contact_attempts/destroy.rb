# frozen_string_literal: true

module Api
  module Controllers
    module ContactAttempts
      class Destroy < Actions::Api
        private

        def safe_call(params)
          commands = params[:contact_attempts].map do |attempt|
            ::Apartments::Commands::UnassignContactAttempt.new(
              attempt.merge(apartment_uuid: params[:apartment_id])
            )
          end

          commands.each do |command|
            execute(command)
          end

          render(status: 201)
        end
      end
    end
  end
end
