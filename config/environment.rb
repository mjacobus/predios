require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/predios'
require_relative '../apps/web/application'
require_relative '../lib/repository'
require_relative '../apps/api/application'

# for some reason this is necessary during hanami db migrate
ENV.fetch('DATABASE_URL') do
  require 'dotenv'
  Dotenv.load
end

Hanami.configure do
  mount Api::Application, at: '/api'
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/predios_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/predios_development'
    #    adapter :sql, 'mysql://localhost/predios_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/predios/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      # delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
