class AddQuestUrlToQuests < ActiveRecord::Migration[5.1]

  def change
    add_column :quests, :quest_url, :string
  end

end
