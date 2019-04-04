# frozen_string_literal: true

require 'dotenv'
Dotenv.load

every 1.hours, roles: [:mysql_dump] do
  rake 'mysql:dump'
end

every 1.day, at: ['5:30 am'], roles: [:mysql_dump] do
  rake 'email_backup'
end

every 1.day, at: ['5:00 am'], roles: [:mysql_dump] do
  rake "geolocation:update[#{ENV.fetch('CITY_NAME')}]"
end
