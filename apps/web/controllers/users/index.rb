# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class Index < Actions::Web
        before :require_master
        expose :users

        def initialize(repository: UserRepository.new)
          @repository = repository
        end

        private

        def safe_call(_params)
          @users = @repository.all
        end
      end
    end
  end
end
