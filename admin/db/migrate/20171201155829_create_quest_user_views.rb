class CreateQuestUserViews < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_user_views do |t|
      t.references :quest_user, foreign_key: true
      t.references :viewable, polymorphic: true
      t.boolean :is_valid, default: true

      t.timestamps
    end
  end
end
