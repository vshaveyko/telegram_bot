class AddPhoneNumberToQuestLocation < ActiveRecord::Migration[5.1]

  def change
    add_column :quest_locations, :phone_number, :string
  end

end
