# frozen_string_literal: true

module Actions
  module UserSessionAware
    def self.included(action)
      action.class_eval do
        before :require_authentication
        expose :current_user
        expose :logged_in?
        expose :user_session
      end
    end

    private

    def user_session
      @user_session ||= UserSessionService.new(
        session: session,
        user_repository: UserRepository.new
      )
    end

    def current_user
      user_session.current_user
    end

    def logged_in?
      current_user.logged_in?
    end

    def require_authentication
      require_logged_in_user
      require_authorized_user
    end

    def require_logged_in_user
      unless current_user.logged_in?
        save_forbidden_url
        handle_unautorized
      end
    end

    def require_authorized_user
      unless current_user.enabled?
        handle_unautorized
      end
    end

    def require_master
      unless current_user.master?
        handle_unautorized
      end
    end

    def handle_unautorized
      redirect_to '/'
    end

    def save_forbidden_url
      session[:redirect_url] = request.url
    end
  end
end
