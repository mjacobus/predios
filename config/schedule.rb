# frozen_string_literal: true

every 1.day, at: ['5:30 am'], roles: [:mysql_dump] do
  rake 'email_backup'
end
