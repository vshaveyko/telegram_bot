class AddQuestCountToQuestLocation < ActiveRecord::Migration[5.1]

  def change
    add_column :quest_locations, :quests_count, :integer, default: 0

    QuestLocation.pluck(:id).each do |p|
      QuestLocation.reset_counters p, :quests
    end
  end

end
