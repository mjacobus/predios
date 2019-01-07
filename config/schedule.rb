# frozen_string_literal: true

set :environment_variable, 'HANAMI_ENV'

every 1.hours, roles: [:mysql_dump] do
  rake 'mysql:dump'
  rake 'mysql:dump_latest'
end

every 1.day, at: ['5:30 am'], roles: [:mysql_dump] do
  rake 'email_backup'
end
