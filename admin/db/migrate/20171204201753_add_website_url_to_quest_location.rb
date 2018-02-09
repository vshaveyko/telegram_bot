class AddWebsiteUrlToQuestLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_locations, :website_url, :string
    add_column :quest_locations, :discounts, :text
  end
end
