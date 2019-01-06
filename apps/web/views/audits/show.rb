# frozen_string_literal: true

module Web
  module Views
    module Audits
      class Show < ::Views::Web
        def format_json(json_string)
          hash = JSON.parse(json_string)
          JSON.pretty_generate(hash)
        end

        def user
          if metadata['user_id']
            @user ||= UserRepository.new.find_by_uuid(metadata['user_id'])
          end

          @user ||= LoggedOutUser.new
        end

        def ip_address
          metadata['ip_address']
        end

        def metadata
          @metadata ||= JSON.parse(audit.metadata)
        end

        def payload
          @payload ||= JSON.parse(audit.payload)
        end
      end
    end
  end
end
