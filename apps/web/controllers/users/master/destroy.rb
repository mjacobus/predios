# frozen_string_literal: true

module Web
  module Controllers
    module Users
      module Master
        class Destroy
          include Web::Action

          before :require_master

          def initialize(repository: UserRepository.new)
            @repository = repository
          end

          def call(params)
            user = @repository.find(params[:user_id])
            @repository.save(user.unmaster)
            redirect_to '/users'
          end
        end
      end
    end
  end
end
