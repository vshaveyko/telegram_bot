if defined?(ActiveAdmin)
ActiveAdmin.register QuestUser do

  controller do
    def permitted_params
      params.permit!
    end

    def create
      super do |format|
        redirect_to edit_resource_url and return if resource.valid?
      end
    end

    def update
      super do |format|
        return if resource.valid?
      end
    end

  end

  index do
    column :first_name
    column :last_name
    column :current_position
    column :latest_location_updated_at

    actions defaults: false do |st|
      link_to 'Редактировать', edit_admin_quest_user_path(st)
    end

    actions defaults: false do |st|
      link_to 'Удалить', admin_quest_user_path(st), :method => 'delete', data: { confirm: 'Вы действительно хотите удалить ?' }
    end
  end

end
end
