# frozen_string_literal: true

class ContactAttemptProjectionRepository < Hanami::Repository
  include Repository

  self.relation = :projection_apartment_contact_attempts
end
