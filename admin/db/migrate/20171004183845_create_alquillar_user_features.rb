class CreateAlquillarUserFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :alquillar_user_features do |t|
      t.string('checked_pages', array: true, default: [])
      t.boolean(:has_next)
      t.integer(:page_index, default: 0)
      t.boolean(:is_valid, default: true)

      t.references :user, foreign_key: { to_table: :alquillar_users }
      t.references :feature, foreign_key: { to_table: :alquillar_features }

      t.timestamps
    end

  end
end
