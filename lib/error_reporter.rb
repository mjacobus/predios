# frozen_string_literal: true

class ErrorReporter
  def report(error, context: {})
    Raven.user_context(context)
    Raven.capture_exception(error)
  end
end
