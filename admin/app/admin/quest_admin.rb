if defined?(ActiveAdmin)
ActiveAdmin.register Quest do

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
    column :quest_location
    column :id

    actions defaults: false do |st|
      link_to 'Редактировать', edit_admin_quest_path(st)
    end

    actions defaults: false do |st|
      link_to 'Удалить', admin_quest_path(st), :method => 'delete', data: { confirm: 'Вы действительно хотите удалить ?' }
    end
  end

  form do |f|

    f.inputs do
      f.input :id, input_html: { readonly: true, disabled: true }
      f.input :name
      f.input :quest_games_quest_id
      f.input :image_url
      f.input :quest_url
      f.input :video_url
      f.input :estimated_time
      f.input :quest_location, as: :select,
                               collection: QuestLocation.all.map { |u| [u.to_s, u.id] },
                               include_blank: false
      f.input :description
    end

    f.inputs "Ppl" do
      f.input :ppl_min
      f.input :ppl_max
    end

    f.inputs "Cost" do
      f.input :cost_min
      f.input :cost_max
    end

    f.inputs do
      f.has_many :comments, heading: 'Comments', allow_destroy: true, new_record: 'Add comment' do |a|
        a.input :body
      end
    end

    f.actions
  end

end
end
