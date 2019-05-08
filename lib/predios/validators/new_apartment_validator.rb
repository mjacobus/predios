# frozen_string_literal: true

class NewApartmentValidator
  def initialize(apartment_repository:)
    @repository = apartment_repository
  end

  def validate(command)
    if command.attributes[:number].to_s.empty?
      raise ValidationError, 'Número não pode ficar em branco'
    end

    found = @repository.find_by_number(
      command.attributes[:number],
      building_uuid: command.attributes[:building_id]
    )

    if found
      raise ValidationError, 'Apartamento já existe'
    end
  end
end
