class TextTranslation < ApplicationRecord

  translates :value

  class << self

    def get_translation(text_alias, vars = nil)
      return unless text_alias # to prevent unpredictable behaviour

      translation = ( translations[text_alias] ||= find_by(text_alias: text_alias)&.value )

      return text_alias unless translation

      vars ? replace_vars(translation, vars) : translation
    end

  private

    def translations
      @translations ||= {}
    end

    def replace_vars(str, vars)
      vars.inject(str) do |res_str, (var, val)|
        res_str.gsub(/{{\s*#{var}\s*}}/, val.to_s || '')
      end
    end

  end

end
