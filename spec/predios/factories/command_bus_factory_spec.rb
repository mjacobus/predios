# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommandBusFactory, type: :factory do
  let(:factory) { described_class.new }
  let(:container) { instance_double(Nurse::DependencyContainer) }
  let(:service) { factory.create_service(container) }

  it 'returns a command bus' do
    resolver = CommandHandlerResolver.new(dependencies: container)
    expected = CommandBus.new([resolver])

    expect(service).to be_equal_to(expected)
  end

  it 'has correct key' do
    expect(factory.dependency_key).to eq('services.command_bus')
  end

  it 'is wired to app dependencies' do
    expect(AppDependencies.new).to be_defined(factory.dependency_key)
  end
end
