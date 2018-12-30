# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :projection_apartment_contact_attempts do
      primary_key :id

      column :outcome, String, null: false
      column :time, DateTime, null: false

      foreign_key :apartment_id, :projection_apartments, on_delete: :cascade, null: false
    end
  end
end
