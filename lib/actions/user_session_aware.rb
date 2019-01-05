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
      unless current_user.enabled?
        session[:redirect_url] = request.url
        redirect_to '/'
      end
    end

    def require_master
      unless current_user.master?
        halt 401
      end
    end
  end
end
