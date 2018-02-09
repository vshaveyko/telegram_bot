# frozen_string_literal: true
namespace :translation do

  desc 'Fill TextTranslation Keys'
  task fill: :environment do
    files = Dir[File.join(File.dirname(__FILE__), '/data/**/*.yml')]

    translations = files.flat_map { |f| YAML.load_file(f) || [] } # false if empty file

    rake_aliases = translations.map { |tr| tr['text_alias'] }

    existing_aliases = TextTranslation.pluck(:text_alias)
    new_aliases = rake_aliases - existing_aliases

    if new_aliases.length.positive?
      translations.each do |translation|
        next unless new_aliases.include? translation['text_alias']

        object = TextTranslation.create(
          text_alias: translation['text_alias'],
          value:      translation['ru']
        )

        # I18n.available_locales.each do |language|
        #   trans = translation[language.to_s]
        #   next unless trans
        #   I18n.locale = language
        #   object.update(value: trans)
        # end

        # I18n.locale = I18n.default_locale
      end
    end

    p 'TextTranslation Aliases filled !'
  end

  desc 'Clear TextTranslation Keys'
  task clear: :environment do
    TextTranslation.destroy_all
    p 'TextTranslation Aliases cleared !'
  end

end
