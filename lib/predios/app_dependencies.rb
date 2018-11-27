# frozen_string_literal: true

require 'nurse'

class AppDependencies < Nurse::DependencyContainer
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def initialize
    super

    add_factory(CommandBusFactory.new)

    add_repository('event') do
      EventEntityRepository.new
    end

    add_repository('aggregate_root') do |container|
      AggregateRootRepository.new(
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
      Koine::EventManager::EventManager.new.tap do |manager|
        manager.attach_listener(Buildings::BuildingsProjections)
      end
    end

    add_command_handler('buildings.import_buildings_from_csv_file') do |container|
      Buildings::CommandHandlers::ImportBuildingsFromCsvFile.new(
        command_bus: container.command_bus,
        csv_parser: container.service('csv_parser')
      )
    end

    add_command_handler('buildings.create_building') do |container|
      Buildings::CommandHandlers::CreateBuilding.new(
        repository: container.repository('aggregate_root'),
        validator: NullValidator.new
      )
    end

    add_service('csv_parser') do
      CsvParser.new
    end
  end

  def repository(name)
    get("repositories.#{name}_repository")
  end

  def service(name)
    get("services.#{name}")
  end

  def command_bus
    service('command_bus')
  end

  private

  def add_repository(name, &block)
    share("repositories.#{name}_repository", &block)
  end

  def add_command_handler(name, &block)
    share("command_handlers.#{name}", &block)
  end

  def add_service(name, &block)
    share("services.#{name}", &block)
  end
end
