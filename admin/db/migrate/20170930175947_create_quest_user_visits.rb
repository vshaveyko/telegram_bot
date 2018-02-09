class CreateQuestUserVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_user_visits do |t|
      t.belongs_to :quest_user, foreign_key: true, index: true
      t.belongs_to :quest, foreign_key: true, index: true

      t.timestamps
    end
  end
end
