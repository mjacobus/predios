# frozen_string_literal: true

module Web
  module Views
    module Audits
      class Index < ::Views::Web
        def next_page
          page + 1
        end

        def previous_page
          page - 1
        end

        def page
          params.to_h.fetch(:page, 1).to_i
        end

        def previous_page?
          previous_page.positive?
        end
      end
    end
  end
end
