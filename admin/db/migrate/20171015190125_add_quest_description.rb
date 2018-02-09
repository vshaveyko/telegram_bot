class AddQuestDescription < ActiveRecord::Migration[5.1]

  def change
    add_column :quests, :description, :text
  end

end
