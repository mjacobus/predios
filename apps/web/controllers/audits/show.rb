# frozen_string_literal: true

module Web
  module Controllers
    module Audits
      class Show < Actions::Web
        before :require_master
        expose :audit

        def call(params)
          @audit = EventEntityRepository.new.find(params[:id])
        end
      end
    end
  end
end
