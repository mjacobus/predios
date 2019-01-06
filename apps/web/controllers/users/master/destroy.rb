# frozen_string_literal: true

module Web
  module Controllers
    module Users
      module Master
        class Destroy < Actions::Web
          before :require_master

          def initialize(repository: UserRepository.new)
            @repository = repository
          end

          private

          def safe_call(params)
            user = @repository.find(params[:user_id])
            @repository.save(user.unmaster)
            redirect_to '/users'
          end
        end
      end
    end
  end
end
