# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class Index < MasterAction
        include ::Web::Action

        expose :users

        def initialize(repository: UserRepository.new)
          @repository = repository
        end

        def call(_params)
          @users = @repository.all
        end
      end
    end
  end
end
