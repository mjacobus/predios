# frozen_string_literal: true

module Repository
  def save(entity)
    if entity.id
      return update(entity.id, entity)
    end

    create(entity)
  end
end
