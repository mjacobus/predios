# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

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
          "Tem certeza de que deseja ativar #{summary(user)}?"
        end

        def confirm_message_for_disable(user)
          "Tem certeza de que deseja desativar #{summary(user)}?"
        end

        def confirm_message_for_master(user)
          "Tem certeza de deseja que #{summary(user)} se torne administrador?"
        end

        def confirm_message_for_unmaster(user)
          "Tem certeza de que deseja remover o privilégio de administrador de #{summary(user)}?"
        end

        def summary(user)
          "#{user.name} (#{user.email})"
        end

        def enabable?(user)
          not_self(user) && !user.enabled?
        end

        def disabable?(user)
          not_self(user) && user.enabled?
        end

        def masterable?(user)
          not_self(user) && !user.master?
        end

        def unmasterable?(user)
          not_self(user) && user.master?
        end

        def not_self(user)
          user.uuid != current_user.uuid
        end
      end
    end
  end
end
