class AddVideoUrlToQuest < ActiveRecord::Migration[5.1]

  def change
    add_column :quests, :video_url, :string
  end

end
