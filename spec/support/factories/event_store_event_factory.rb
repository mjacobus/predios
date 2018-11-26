# frozen_string_literal: true

require_relative './entity_factory'

class EventStoreEventFactory < EntityFactory
  private

  # rubocop:disable Metrics/MethodLength
  def sampled_attributes
    %i[
      uuid
      payload
      metadata
      aggregate_type
      aggregate_id
      aggregate_version
      event_id
      event_type
      event_time
    ]
  end

  def sample_event_time(_seq)
    Time.now
  end

  def sample_event_type(_seq)
    Articles::Events::ArticleCreated.to_s
  end

  def sample_aggregate_version(seq)
    seq
  end

  def sample_aggregate_type(_seq)
    Articles::Article.to_s
  end

  def sample_metadata(_seq)
    { metadata: :data }.to_json
  end

  def sample_payload(_seq)
    { payload: :data }.to_json
  end
end
