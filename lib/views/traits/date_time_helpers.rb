# frozen_string_literal: true

module Views
  module Traits
    module DateTimeHelpers
      def format_date(date)
        unless date
          return
        end

        date.strftime('%d/%m/%Y')
      end

      def format_time(time)
        unless time
          return
        end

        time.localtime.strftime('%d/%m/%Y %H:%M')
      end
    end
  end
end
