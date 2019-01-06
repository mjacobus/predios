# frozen_string_literal: true

module Web
  module Controllers
    module Users
      module Enable
        class Create < Actions::Web
          before :require_master

          def initialize(repository: UserRepository.new)
            @repository = repository
          end

          private

          def safe_call(params)
            user = @repository.find(params[:user_id])
            @repository.save(user.enable)
            redirect_to '/users'
          end
        end
      end
    end
  end
end
