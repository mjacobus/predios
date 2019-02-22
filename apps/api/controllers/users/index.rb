# frozen_string_literal: true

module Api
  module Controllers
    module Users
      class Index < Actions::Api
        before :require_master

        def initialize(repository: UserRepository.new)
          @repository = repository
        end

        private

        def safe_call(_params)
          users = @repository.all
          render(body: to_json(users))
        end

        def to_json(users)
          users.map do |user|
            {
              name: user.name,
              email: user.email,
              avatar_url: user.avatar_url,
              master: user.master,
              enabled: user.enabled,
            }
          end
        end
      end
    end
  end
end
