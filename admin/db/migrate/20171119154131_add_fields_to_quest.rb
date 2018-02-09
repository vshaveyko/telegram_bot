class AddFieldsToQuest < ActiveRecord::Migration[5.1]

  def change
    add_column :quests, :info_type, :integer, default: 0
    add_column :quests, :schedule_text, :text
  end

end
