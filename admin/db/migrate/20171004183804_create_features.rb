class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :alquillar_features do |t|
      t.string(:type)
      t.string(:geometry_type)

      t.float(:geometry_lat)
      t.float(:geometry_long)
      t.st_point :position

      t.string(:geohash_prefix)

      t.timestamps
    end
  end
end
