# frozen_string_literal: true

class RackResponse < SimpleDelegator
  def status
    self[0].to_i
  end

  def headers
    self[1]
  end

  def redirect?
    [301, 302].include?(status)
  end

  def body
    self[2]
  end

  def success?
    status < 300 && status >= 200
  end

  def forbidden?
    status >= 400 && status < 500
  end

  def redirect_url
    headers['Location']
  end

  def self.wrap(response)
    if response.is_a?(self)
      return response
    end

    new(response)
  end
end

RSpec::Matchers.define :redirect_to do |expected, status = nil|
  match do |response|
    response = RackResponse.wrap(response)

    if status
      expect(response.status).to eq(status)
    else
      expect(response).to be_redirect
    end

    expect(response.redirect_url).to eq(expected)
  end

  failure_message do |response|
    response = RackResponse.wrap(response)

    [
      "Expected redirect to #{expected}, status: #{status}",
      "but it was #{response.redirect_url}, status: #{response.status}",
    ].join(' ')
  end

  failure_message_when_negated do |_response|
    "Expected not to redirect to #{expected} but it did"
  end
end

RSpec::Matchers.define :be_successful do |_expected, _status = nil|
  match do |response|
    response = RackResponse.wrap(response)

    expect(response).to be_success
  end

  failure_message do |response|
    response = RackResponse.wrap(response)
    "Expected response to be successful but it has status #{response.status}"
  end

  failure_message_when_negated do |response|
    response = RackResponse.wrap(response)
    "Expected response to not to be successful but it has status #{response.status}"
  end
end

RSpec::Matchers.define :be_unauthorized do |_expected, _status = nil|
  match do |response|
    response = RackResponse.wrap(response)

    expect(response).to be_forbidden
  end

  failure_message do |response|
    response = RackResponse.wrap(response)
    "Expected response to be unauthorized but it has status #{response.status}"
  end

  failure_message_when_negated do |response|
    response = RackResponse.wrap(response)
    "Expected response to not to be unauthorized but it has status #{response.status}"
  end
end

RSpec::Matchers.define :redirect_to_root do |_expected, _status = nil|
  match do |response|
    response = RackResponse.wrap(response)

    expect(response).to redirect_to('/')
  end
end
