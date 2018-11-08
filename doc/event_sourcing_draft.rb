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
