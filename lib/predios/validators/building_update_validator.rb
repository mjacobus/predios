# frozen_string_literal: true

class BuildingUpdateValidator
  # rubocop:disable Metrics/MethodLength
  def validate(building)
    unless building.name
      missing('Nome do Condomínio')
    end

    unless building.address
      missing('Endereço')
    end

    unless building.number_of_apartments
      missing('Número de Apartamentos')
    end

    unless building.neighborhood
      missing('Bairro')
    end
  end

  private

  def missing(field)
    raise ValidationError, "#{field} não pode ficar em branco"
  end
end
