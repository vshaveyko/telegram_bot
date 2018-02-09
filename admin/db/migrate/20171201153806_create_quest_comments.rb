class CreateQuestComments < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_comments do |t|
      t.references :quest, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
