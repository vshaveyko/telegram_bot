if defined?(ActiveAdmin)
ActiveAdmin.register TextTranslation do

  menu priority: 3, label: 'Переводы'

  TextTranslation.active_admin_translates :value

  includes :translations

  controller do
    def permitted_params
      params.permit!
    end

    def create
      super do |format|
        redirect_to new_resource_url and return if resource.valid?
      end
    end

    def update
      super do |format|
        return redirect_to action: 'index' if resource.valid?
      end
    end

  end

  filter :created_at, label: 'Дата создания'

  filter :text_alias, label: 'Ключ перевода'
  filter :translations_value, as: :string, label: 'Текст перевода'

  scope :all, default: true, label: 'Все'
  #
  # I18n.available_locales.each do |locale|
  #   scope("Без перевода на #{locale}") { |scope| scope.without_translation(locale) }
  # end

  index do
    column('Ключ перевода', :text_alias)
    column('Текст перевода', :value)

    translation_status
    # translation_status_flags

    actions defaults: false do |st|
      link_to 'Редактировать', edit_admin_text_translation_path(st)
    end

    actions defaults: false do |st|
      link_to 'Удалить', admin_text_translation_path(st), :method => 'delete', data: { confirm: 'Вы действительно хотите удалить перевод?' }
    end

  end

  form do |f|
    # ...
    f.inputs do
      if f.object.new_record?
        input :text_alias
      else
        input :text_alias, input_html: { readonly: true, disabled: true }
      end
    end

    f.inputs "Translated fields" do
      f.translated_inputs 'ignored title', switch_locale: false, default_locale: :ru do |t|
        t.input :value
      end

    end

    actions
    # ...
  end

end
end
