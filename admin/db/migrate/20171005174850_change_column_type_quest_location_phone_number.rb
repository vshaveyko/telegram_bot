class ChangeColumnTypeQuestLocationPhoneNumber < ActiveRecord::Migration[5.1]

  def up
    change_column :quest_locations, :phone_number, :text
  end

  def down
    change_column :quest_locations, :phone_number, :string
  end

end
