if defined?(ActiveAdmin)
ActiveAdmin.register QuestLocation do

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
    column :name
    tag_column :feature_type
    column :address

    actions defaults: false do |st|
      link_to 'Редактировать', edit_admin_quest_location_path(st)
    end

    actions defaults: false do |st|
      link_to 'Удалить', admin_quest_location_path(st), :method => 'delete', data: { confirm: 'Вы действительно хотите удалить ?' }
    end
  end

  form do |f|

    f.inputs do
      f.input :id, input_html: { readonly: true, disabled: true }
      f.input :name
      f.input :feature_type, as: :select,
                             collection: QuestLocation.feature_types.keys,
                             include_blank: false
      f.input :phone_number
      f.input :address
      f.input :image_url
    end

    f.inputs "Location" do
      f.input :lat
      f.input :long
    end

    f.inputs do
      f.has_many :quests, heading: 'Quests', allow_destroy: true, new_record: 'Add quest' do |a|
        a.input :name
        a.input :quest_games_quest_id
        a.input :image_url
        a.input :quest_url
        a.input :video_url
        a.input :estimated_time
        a.input :description

        a.input :ppl_min
        a.input :ppl_max

        a.input :info_type, as: :select,
                            collection: Quest.info_types.keys,
                            include_blank: false

        a.input :schedule_text

        a.input :cost_min
        a.input :cost_max
      end
    end

    f.actions
  end


end
end
