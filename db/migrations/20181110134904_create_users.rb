# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :name, String, null: false
      column :email, String, null: false
      column :oauth_provider, String, null: false
      column :oauth_uid, String, null: false
      column :uuid, String, null: false, unique: true
      column :avatar, String, null: true

      column :master, TrueClass, default: false
      column :enabled, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
