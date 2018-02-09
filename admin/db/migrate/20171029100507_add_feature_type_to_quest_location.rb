class AddFeatureTypeToQuestLocation < ActiveRecord::Migration[5.1]

  def change
    add_column :quest_locations, :feature_type, :integer, default: 0
  end

end
