# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/', to: 'home#index'
get '/auth/:provider/callback', to: 'sessions#create'
get 'logout', to: 'sessions#destroy'

resources :users, only: [:index] do
  resource :enable, only: %i[create destroy]
  resource :master, only: %i[create destroy]
end

resources :buildings, only: [:index, :show]
