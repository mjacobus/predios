# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :domain_events_store do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :event_id, String, null: false, index: true
      column :event_type, String, null: false, index: true

      column :payload, String, null: false, text: true
      column :metadata, String, null: false, text: true

      column :event_time, DateTime, null: false
      column :aggregate_type, String, null: false, index: true
      column :aggregate_id, String, null: false, index: true
      column :aggregate_version, Integer, null: false
    end
  end
end
