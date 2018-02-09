# frozen_string_literal: true

Sequel.migration do
  transaction
  change do
    DB.extension(:pg_array)

    create_table(:users_features) do
      primary_key(:id, type: :Bignum)

      column('checked_pages', 'text[]', default: [])
      column(:has_next,       :boolean)
      column(:page_index,     :integer, default: 0)
      column(:is_valid,       :boolean, default: true)

      foreign_key(:user_id, :users)
      foreign_key(:feature_id, :features)
    end
  end
end
