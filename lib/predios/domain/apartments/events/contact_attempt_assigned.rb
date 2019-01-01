# frozen_string_literal: true

require 'domain_event'

module Apartments
  module Events
    class ContactAttemptAssigned < DomainEvent
      def time
        TimeCoercer.new.coerce(payload[:time])
      end

      def outcome
        payload[:outcome].to_s
      end
    end
  end
end
