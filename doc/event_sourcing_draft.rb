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


Buildings::Queries::FindBuildingById.new
Buildings::Queries::FindBuildingsByTerritoryId.new


Buildings::Processors::NotifyPublisherOfAssignment.new

Buildings::Projections::BuildingFinder.new
