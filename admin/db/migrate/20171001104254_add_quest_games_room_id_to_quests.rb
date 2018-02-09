class AddQuestGamesRoomIdToQuests < ActiveRecord::Migration[5.1]
  def change
    add_column :quests, :quest_games_quest_id, :string
  end
end
