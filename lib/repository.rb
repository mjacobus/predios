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
    send(relation).where(uuid: uuid.to_s).first
  end

  def delete_by_uuid(uuid)
    entity = by_uuid(uuid)
    delete(entity.id)
  end

  # should be used in test only, since it counts all records
  def count
    unless Hanami.env == 'test'
      raise 'Should not be used in production'
    end

    all.length
  end
end
