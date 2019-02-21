# frozen_string_literal: true

class ApartmentProjection < Entity
  def contact_attempts
    super.sort_by(&:time)
  end

  def domain_contact_attempts
    attempts = contact_attempts.map do |attempt|
      Apartments::ContactAttempt.new(
        outcome: attempt.outcome,
        time: attempt.time,
        type: attempt.type
      )
    end

    Apartments::ContactAttempts.new(attempts)
  end

  def last_contacted_time
    contact_attempts.select(&:successful?).last&.time
  end

  def last_failed_contact_attempt_time
    contact_attempts.reject(&:successful?).last&.time
  end

  def last_contact_attempt
    contact_attempts.last
  end

  def ever_contacted?
    !last_contacted_time.nil?
  end
end
