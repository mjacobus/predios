# frozen_string_literal: true

class UserFactory < EntityFactory
  private

  def sampled_attributes
    %i[
      name
      email
      oauth_provider
      oauth_uid
    ]
  end
end
