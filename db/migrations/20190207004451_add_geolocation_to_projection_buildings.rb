# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :projection_buildings do
      add_column :lat, Float, null: true
      add_column :lon, Float, null: true
    end
  end
end
