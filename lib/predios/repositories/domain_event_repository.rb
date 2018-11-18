# frozen_string_literal: true

class DomainEventRepository < Hanami::Repository
  self.relation = :domain_events_store

  def find_by(id:, type: nil)
    params = { aggregate_id: id }

    if type
      params[:aggregate_type] = type.to_s
    end

    domain_events_store.where(params).to_a.map(&:to_event)
  end

  def store(event)
    entity = DomainEvent.from_domain_event(event)
    create(entity)
  end
end
