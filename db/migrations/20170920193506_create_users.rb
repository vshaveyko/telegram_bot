# frozen_string_literal: true

Sequel.migration do
  transaction
  change do
    DB.extension(:pg_array)

    create_table(:users) do
      primary_key(:id, type: :Bignum)

      column(:first_name,            :text)
      column(:last_name,             :text)
      column(:username,              :text)
      column(:telegram_user_id,      :text)
      column('checked_features_ids', 'text[]', default: [])
      column(:current_position,      'geometry(Point, 4326)')
      column(:last_position,         'geometry(Point, 4326)')
    end
  end
end
