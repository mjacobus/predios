# frozen_string_literal: true

module Web
  module Controllers
    module Users
      module Enable
        class Destroy < Actions::Web
          before :require_master

          def initialize(repository: UserRepository.new)
            @repository = repository
          end

          def call(params)
            user = @repository.find(params[:user_id])
            @repository.save(user.disable)
            redirect_to '/users'
          end
        end
      end
    end
  end
end
