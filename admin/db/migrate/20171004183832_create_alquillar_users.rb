class CreateAlquillarUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :alquillar_users do |t|
      t.string(:first_name)
      t.string(:last_name)
      t.string(:username)
      t.string(:telegram_user_id)
      t.st_point(:current_position)
      t.st_point(:last_position)

      t.timestamps
    end
  end
end
