# frozen_string_literal: true

# :nodoc:
class User < Sequel::Model(:alquillar_users)

  many_to_many :features, class: :'Lunua::Feature',
                          join_table: Lunua::UsersFeature.table_name,
                          right_key: :user_id

  many_to_many :features_with_pages, clone: :features,
                                     condition: [[Sequel.lit("#{Lunua::UsersFeature.table_name}.has_next"), true]],
                                     order: Sequel.lit("#{Lunua::UsersFeature.table_name}.id")

  one_to_many :user_features, class: :'Lunua::UsersFeature',
                              conditions: { has_next: true, is_valid: true },
                              order: Sequel.lit('id')

  def before_create
    self.created_at ||= Time.now
    self.updated_at ||= Time.now
    super
  end

  def current_position=(args)
    long, lat = args

    super(
      Sequel.lit("ST_GeomFromText('POINT(#{long} #{lat})', 4326)")
    )
  end

  def invalidate_features!
    user_features_dataset.update(is_valid: false)
  end

end
