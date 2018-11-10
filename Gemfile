source 'https://rubygems.org'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'dotenv', '~> 2.4'
gem 'mysql2'

# frontend
gem 'babel-transpiler'
gem 'sass'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby

  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-chruby', require: false
  gem 'capistrano-hanami', require: false

  gem 'rubocop', '0.58', require: nil
  gem 'rubocop-rspec', '~>1.30', require: nil
end

group :test do
  gem 'capybara'
  gem 'rspec'
end

group :production do
  # gem 'puma'
end
