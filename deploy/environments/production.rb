# frozen_string_literal: true

server fetch(:application),
  user: 'deploy',
  roles: %w[web app mysql_dump],
  ssh_options: {
    user: 'deploy', # overrides user setting above
    forward_agent: true,
    auth_methods: %w[publickey password],
  }
