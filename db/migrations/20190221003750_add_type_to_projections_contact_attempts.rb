# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :projection_apartment_contact_attempts do
      add_column :type, String, null: false, default: 'intercom'
    end
  end
end
