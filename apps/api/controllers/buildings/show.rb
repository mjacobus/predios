# frozen_string_literal: true

module Api
  module Controllers
    module Buildings
      class Show < Actions::Api
        def initialize(repository: BuildingProjectionRepository.new)
          @repository = repository
        end

        private

        def safe_call(params)
          building = @repository.find_by_number(params[:id])
          body = building_to_json(building)
          render(status: 200, body: body)
        end

        def building_to_json(building)
          {
            id: building.id,
            uuid: building.uuid,
            number: building.number,
            address: building.address,
            number_of_apartments: building.number_of_apartments,
            name: building.name,
            neighborhood: building.neighborhood,
            call_options: building.call_options,
            has_all_apartments: building.has_all_apartments?,
            apartments: building.apartments.map do |apartment|
              apartment_to_json(apartment)
            end,
          }
        end

        def apartment_to_json(apartment)
          {
            id: apartment.id,
            uuid: apartment.uuid,
            number: apartment.number,
            last_contact_attempt: contact_attempt_to_json(apartment.last_contact_attempt),
            history: apartment.contact_attempts.map do |attempt|
              contact_attempt_to_json(attempt)
            end,
          }
        end

        def contact_attempt_to_json(attempt)
          unless attempt
            return nil
          end

          {
            successful: attempt.successful?,
            outcome: attempt.outcome,
            time: as_time(attempt.time),
          }
        end

        def as_time(time)
          time.localtime.strftime('%d/%m/%Y %H:%M')
        end
      end
    end
  end
end
