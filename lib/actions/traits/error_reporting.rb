# frozen_string_literal: true

module Actions
  module Traits
    module ErrorReporting
      private

      def report_error(error)
        error_reporter.report(error, context: error_context)
      end

      def error_reporter
        if report_errors?
          return ErrorReporter.new
        end

        NullErrorReporter.new
      end

      def report_errors?
        !%w[development test].include?(Hanami.env)
      end

      def error_context
        {
          user_id: current_user.id,
          user_uuid: current_user.uuid,
          user_name: current_user.name,
          user_email: current_user.email,
        }
      end
    end
  end
end
