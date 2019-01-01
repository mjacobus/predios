# frozen_string_literal: true

class ContactAttemptProjection < Entity
  def successful?
    outcome.to_s == 'contacted'
  end
end
