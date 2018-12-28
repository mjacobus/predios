# frozen_string_literal: true

module Web
  module Views
    module Audits
      class Index
        include Web::View

        def next_page
          page + 1
        end

        def previous_page
          page - 1
        end

        def page
          params[:page].to_i
        end

        def previous_page?
          previous_page.positive?
        end
      end
    end
  end
end
