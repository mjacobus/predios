# frozen_string_literal: true

class DomainEventRepository < Hanami::Repository
  def find_by(id:, type: nil)
    params = { aggregate_id: id }

    if type
      params[:aggregate_type] = type.to_s
    end

    domain_events.where(params).to_a.map(&:to_event)
  end
end
