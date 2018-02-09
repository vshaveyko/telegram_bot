class CreateQuest < ActiveRecord::Migration[5.1]

  def change
    create_table :quests do |t|
      t.integer :ppl_min
      t.integer :ppl_max
      t.integer :cost_min
      t.integer :cost_max

      t.float :lat
      t.float :long

      t.string :name
      t.string :image_url
      t.string :address
      t.string :estimated_time

      t.st_point :position, geographic: true
    end
  end

end
