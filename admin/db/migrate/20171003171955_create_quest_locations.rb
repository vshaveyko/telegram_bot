class CreateQuestLocations < ActiveRecord::Migration[5.1]

  def change
    create_table :quest_locations do |t|
      t.float "lat"
      t.float "long"
      t.string "address"
      t.string :name
      t.string :image_url
      t.st_point :position, geographic: true

      t.timestamps
    end

    add_reference :quests, :quest_location

    remove_column :quests,"lat", :float
    remove_column :quests,"long", :float
    remove_column :quests,"address", :float
    remove_column :quests,:position, :st_point
  end

end
