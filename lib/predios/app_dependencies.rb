# frozen_string_literal: true

require 'nurse'

class AppDependencies < Nurse::DependencyContainer
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def initialize
    super

    add_factory(CommandBusFactory.new)

    add_repository('event') do
      EventStoreEventRepository.new
    end

    add_repository('aggregate_root') do |container|
      Koine::EventSourcing::AggregateRootRepository.new(
        event_store: container.get('es.event_store'),
        projectors: container.get('es.projectors'),
        processors: container.get('es.processors')
      )
    end

    share('es.event_store') do |container|
      repository = container.repository('event')
      Koine::EventSourcing::EventStore.new(repository: repository)
    end

    share('es.processors') do
      Koine::EventSourcing::NullProcessors.new
    end

    share('es.projectors') do |container|
      event_manager = container.get('es.projection_events')
      Koine::EventSourcing::Projectors.new(event_manager: event_manager)
    end

    share('es.projection_events') do |_container|
      Koine::EventManager::EventManager.new
    end
  end

  def repository(name)
    get("repositories.#{name}_repository")
  end

  def service(name)
    get("services.#{name}")
  end

  private

  def add_repository(name, &block)
    share("repositories.#{name}_repository", &block)
  end
end
