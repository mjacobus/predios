# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :projection_apartments do
      primary_key :id

      column :uuid, String, null: false, unique: true, length: 36
      column :number, String, null: false
      foreign_key :building_id, :projection_buildings, on_delete: :cascade, null: false

      index %i[building_id number], unique: true
    end
  end
end
