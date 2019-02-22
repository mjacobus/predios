# frozen_string_literal: true

module Api
  module Controllers
    module Users
      module Master
        class Create < Actions::Api
          before :require_master

          def initialize(repository: UserRepository.new)
            @repository = repository
          end

          private

          def safe_call(params)
            user = @repository.find(params[:user_id])
            @repository.save(user.as_master)
            render(body: {})
          end
        end
      end
    end
  end
end
