# frozen_string_literal: true

class DummyAction
  include Web::Action
  include Actions::UserSessionAware

  def call(_params)
    response.body = 'ok'
    response.status = 200
  end
end
