# frozen_string_literal: true

module Web
  module Controllers
    module Audits
      class Index
        include Web::Action

        before :require_master
        expose :audits

        def call(params)
          @audits = EventEntityRepository.new.paginate(page: params[:page])
        end
      end
    end
  end
end
