class AddUsersLatestLocationUpdateAt < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_users, :latest_location_updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
