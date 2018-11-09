# frozen_string_literal: true

class User < Entity
  mutator_for :name
  mutator_for :email
  mutator_for :avatar
  mutator_for :uuid
  mutator_for :oauth_uid
  mutator_for :oauth_provider

  def initialize(attributes = {})
    unless attributes[:uuid]
      attributes[:uuid] = UniqueId.new.to_s
    end

    super(attributes)
  end

  def as_master
    with_attribute(:master, true)
  end

  def enable
    with_attribute(:enabled, true)
  end

  def master?
    master
  end

  def enabled?
    enabled
  end

  def uuid
    UniqueId.new(attributes[:uuid])
  end

  def logged_in?
    true
  end
end
