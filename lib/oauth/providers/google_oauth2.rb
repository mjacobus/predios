# frozen_string_literal: true

module Oauth
  module Providers
    class GoogleOauth2
      attr_reader :provider
      attr_reader :uid
      attr_reader :name
      attr_reader :email
      attr_reader :image

      def initialize(attributes)
        @provider = 'google'
        @uid = attributes.fetch('uid')
        attributes.fetch('info').tap do |info|
          @name = info.fetch('name')
          @email = info.fetch('email')
          @image = info.fetch('image')
        end
      end
    end
  end
end
