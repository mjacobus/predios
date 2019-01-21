# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
resource :session

resources :buildings do
  resources :apartments, only: %i[create destroy], controller: :apartments do
    member do
      post :assign_visit_attempt
    end
  end
end
