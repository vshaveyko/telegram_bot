class AddUserLatestMessageAt < ActiveRecord::Migration[5.1]

  def change
    add_column :quest_users, :latest_message_at, :datetime
  end

end
