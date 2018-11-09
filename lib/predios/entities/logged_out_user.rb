# frozen_string_literal: true

class LoggedOutUser
  def logged_in?
    false
  end

  def enabled?
    false
  end
end
