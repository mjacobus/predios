# frozen_string_literal: true

module Repository
  def save(entity)
    if entity.id
      return update(entity.id, entity)
    end

    create(entity)
  end

  def by_uuid(uuid)
    relation = relations.to_h.keys.first
    send(relation).where(uuid: uuid).first
  end
end
