# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :projection_buildings do
      primary_key :id

      column :number, String, null: false, unique: true
      column :uuid, String, null: false, unique: true, length: 36

      column :name, String, null: true
      column :address, String, null: false
      column :number_of_apartments, Integer, null: true
      column :neighborhood, String, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
