# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :projection_buildings do
      primary_key :id

      column :uuid, String, null: false, unique: true, length: 36
      column :address, String, null: false, unique: true
      column :number, String, null: false, unique: true
      column :number_of_apartments, Integer, null: false, unique: true
      column :building_name, String, null: false, unique: true
      column :neighborhood, String, null: false, unique: true, index: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
