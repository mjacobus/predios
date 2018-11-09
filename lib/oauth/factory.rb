# frozen_string_literal: true

module Oauth
  class Factory
    InvalidProvider = Class.new(ArgumentError)

    def create(payload)
      provider_name = payload['provider']
      provider_class = Hanami::Utils::String.classify(provider_name)

      class_name = "Oauth::Providers::#{provider_class}"
      klass = Object.const_get(class_name)
      klass.new(payload)
    rescue NameError
      raise InvalidProvider, "Invalid provider '#{provider_name}'"
    end
  end
end
