# frozen_string_literal: true

class UserRepository < Hanami::Repository
  include Repository

  def find_by_oauth(provider:, uid:)
    users.where(oauth_provider: provider, oauth_uid: uid).first
  end

  def empty?
    all.count.zero?
  end
end
