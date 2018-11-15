# frozen_string_literal: true

Buildings::Events::BuildingCreated.new
Buildings::Events::BuildingUpdated.new
Buildings::Events::BuildingAssignedToPublisher.new
Buildings::Events::BuildingReturnedByPublisher.new

Buildings::Commands::CreateBuilding.new
Buildings::Commands::UpdateBuilding.new
Buildings::Commands::ChangeBuildingAddress.new

Buildings::CommandHandlers::CreateBuilding.new
Buildings::CommandHandlers::UpdateBuilding.new
Buildings::CommandHandlers::ChangeBuildingAddress.new
Buildings::CommandHandlers::FindBuildingById.new

Buildings::Queries::FindBuildingById.new
Buildings::Queries::FindBuildingsByTerritoryId.new

Buildings::Processors::NotifyPublisherOfAssignment.new

Buildings::Projections::BuildingFinder.new

class ChangeBuildingAddress
  def handle(command)
    unless validattor.valid?(command)
      raise InvalidAddress
    end

    aggregate = finder.find(command.aggreagate_root)

    event = AddressChanged.new(
      street_name: command.street_name,
      house_number: command.house_number
    )

    aggregate.apply(event)
  end
end

# mysql> describe projections;
# +--------------+--------------+------+-----+---------+----------------+
# | Field        | Type         | Null | Key | Default | Extra          |
# +--------------+--------------+------+-----+---------+----------------+
# | no           | bigint(20)   | NO   | PRI | NULL    | auto_increment |
# | name         | varchar(150) | NO   | UNI | NULL    |                |
# | position     | json         | YES  |     | NULL    |                |
# | state        | json         | YES  |     | NULL    |                |
# | status       | varchar(28)  | NO   |     | NULL    |                |
# | locked_until | char(26)     | YES  |     | NULL    |                |
# +--------------+--------------+------+-----+---------+----------------+
# 6 rows in set (0.00 sec)

# mysql> desc _1fa6db3f83285acae5950c337a3c3bc26087d0e0;
# +-------------------+------------------+------+-----+---------+------------------+
# | Field             | Type             | Null | Key | Default | Extra            |
# +-------------------+------------------+------+-----+---------+------------------+
# | no                | bigint(20)       | NO   | PRI | NULL    | auto_increment   |
# | event_id          | char(36)         | NO   | UNI | NULL    |                  |
# | event_name        | varchar(100)     | NO   |     | NULL    |                  |
# | payload           | json             | NO   |     | NULL    |                  |
# | metadata          | json             | NO   |     | NULL    |                  |
# | created_at        | datetime(6)      | NO   |     | NULL    |                  |
# | aggregate_version | int(11) unsigned | NO   |     | NULL    | STORED GENERATED |
# | aggregate_id      | char(36)         | NO   |     | NULL    | STORED GENERATED |
# | aggregate_type    | varchar(150)     | NO   | MUL | NULL    | STORED GENERATED |
# +-------------------+------------------+------+-----+---------+------------------+
# 9 rows in set (0.00 sec)

# - from event stream
# - persist aggregate
# - mark aggregate aggregate
# - aggregate version
#

EventSourcing::DomainEvent.new
EventSourcing::AggregateRoot.new
EventSourcing::AggregateRootRepository.new

EventSourcing::EventStore.new(adapter, event_listener)
item = EventSourcing::EventStoreItem.from_aggregate_root_and_domain_event(aggregate, domain_event)
store.persist(item)
event_listener.propagate(domain_event) # spread the word!
store.by_uuid(uuid)


events = store.all_by(aggregate_type: type, aggregate_id: uuid)
