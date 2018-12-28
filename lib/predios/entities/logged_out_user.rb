# frozen_string_literal: true

class LoggedOutUser
  def logged_in?
    false
  end

  def enabled?
    false
  end

  def master?
    false
  end

  def id
    0
  end

  def uuid
    'guest-0'
  end

  def name
    'Loggout out'
  end

  def email
    'no-email'
  end
end
