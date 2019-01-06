# frozen_string_literal: true

module Views
  module Traits
    module AssetsHelpers
      def custom_stylesheet(file, options = {})
        file = remote_or_local_vendor_file(file, options.delete(:alternative))
        stylesheet(file, options)
      end

      def custom_javascript(file, options = {})
        file = remote_or_local_vendor_file(file, options.delete(:alternative))
        javascript(file, options)
      end

      private

      def remote_or_local_vendor_file(file, alternative)
        if ENV['LOCAL_ASSETS']
          alternative ||= file.to_s.split('/').last
          return "vendor/#{alternative}"
        end

        file
      end
    end
  end
end
