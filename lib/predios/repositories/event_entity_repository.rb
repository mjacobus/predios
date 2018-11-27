# frozen_string_literal: true

class EventEntityRepository < Hanami::Repository
  self.relation = :domain_events_store
  self.entity_name = Hanami::Model::EntityName.new('EventEntity')

  def find_by(id:, type: nil)
    params = { aggregate_id: id.to_s }

    if type
      params[:aggregate_type] = type.to_s
    end

    domain_events_store.where(params).to_a.map(&:to_event)
  end

  def store(event)
    entity = EventEntity.from_domain_event(event)
    create(entity)
  end
end