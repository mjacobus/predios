# frozen_string_literal: true

module Web
  module Views
    module Users
      class Index
        include Web::View

        def enable_url(user)
          "/users/#{user.id}/enable"
        end

        def master_url(user)
          "/users/#{user.id}/master"
        end

        def confirm_message_for_enable(user)
          "Tem certeza de que deseja ativar o usuário #{summary(user)}?"
        end

        def confirm_message_for_disable(user)
          "Tem certeza de que deseja desativar o usuário #{summary(user)}?"
        end

        def summary(user)
          "#{user.name} (#{user.email})"
        end
      end
    end
  end
end
