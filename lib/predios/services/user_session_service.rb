# frozen_string_literal: true

class UserSessionService
  UserNotFound = Class.new(Errors::NotFound)

  USER_ID_KEY = 'user.id'

  def initialize(session:, user_repository:)
    @session = session
    @user_repository = user_repository
  end

  def create_from_oauth(oauth)
    user = find_by_oauth(oauth) || User.new
    user = with_oauth_attributes(user, oauth)
    save_user(user)
  end

  def current_user
    @current_user ||= begin
      @user_repository.find(current_user_id) || LoggedOutUser.new
    end
  end

  def destroy
    @session.delete(USER_ID_KEY)
    @current_user = nil
  end

  private

  def find_by_oauth(oauth)
    @user_repository.find_by_oauth(provider: oauth.provider, uid: oauth.uid)
  end

  def save_user(user)
    if @user_repository.empty?
      user = user.enable.as_master
    end

    @session[USER_ID_KEY] = @user_repository.save(user).id
    user
  end

  def with_oauth_attributes(user, oauth)
    user.with_email(oauth.email)
      .with_name(oauth.name)
      .with_oauth_uid(oauth.uid)
      .with_oauth_provider(oauth.provider)
      .with_avatar(oauth.image)
  end

  def current_user_id
    @session[USER_ID_KEY]
  end
end
