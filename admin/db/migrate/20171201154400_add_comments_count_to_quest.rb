class AddCommentsCountToQuest < ActiveRecord::Migration[5.1]

  def change
    add_column :quests, :comments_count, :integer, default: 0
  end

end
