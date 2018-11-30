# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :projection_buildings do
      add_column :has_individual_letterboxes, TrueClass, null: true
      add_column :has_individual_intercoms, TrueClass, null: true
    end
  end
end
