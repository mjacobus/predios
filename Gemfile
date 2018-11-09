source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'mysql2'
gem 'dotenv', '~> 2.4'

# frontend
gem 'sass'
gem 'babel-transpiler'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'

  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-chruby', require: false
  gem 'capistrano-hanami', require: false
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
