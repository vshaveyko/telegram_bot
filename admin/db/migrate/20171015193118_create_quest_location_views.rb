class CreateQuestLocationViews < ActiveRecord::Migration[5.1]

  def change
    create_table :quest_location_views do |t|
      t.belongs_to :quest_user, foreign_key: true
      t.belongs_to :quest_location, foreign_key: true
      t.boolean :is_valid, default: true

      t.timestamps
    end
  end

end
