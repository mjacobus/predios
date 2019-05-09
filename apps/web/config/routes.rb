# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/', to: 'home#index'
get '/auth/:provider/callback', to: 'sessions#create'
get 'logout', to: 'sessions#destroy'

get '/users', to: 'frontend#index'
get '/buildings', to: 'frontend#index'
get '/buildings/:id', to: 'frontend#index'
get '/buildings/:id/edit', to: 'frontend#index'
get '/map', to: 'map#index'

resources :audits, only: %i[index show]

if Hanami.env == 'development' || Hanami.env == 'test'
  get '/dev/login', to: 'dev#login'
end

get '/*', to: 'frontend#index'
