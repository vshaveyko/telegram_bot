class CreateTranslations < ActiveRecord::Migration[5.1]

  class TextTranslation < ActiveRecord::Base

    translates :value

  end

  def up
    create_table :text_translations do |t|
      t.string :text_alias, index: { unique: true }

      t.timestamps
    end

    TextTranslation.create_translation_table!(value:  :text)
  end

  def down
    TextTranslation.drop_translation_table!

    drop_table :text_translations
  end

end
