class CreateQuestUsers < ActiveRecord::Migration[5.1]

  def change
    create_table :quest_users do |t|

      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :telegram_user_id

      t.st_point :current_position, geographic: true

      t.timestamps
    end
  end

end
