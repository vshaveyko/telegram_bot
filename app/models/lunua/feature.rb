# frozen_string_literal: true

# :nodoc:
class Lunua::Feature < Sequel::Model(:alquillar_features)

  one_to_many :users_features
  many_to_many :users, join_table: Lunua::UsersFeature.table_name, class: :User

  def before_create
    self.created_at ||= Time.now
    self.updated_at ||= Time.now
    super
  end

  def position=(args)
    long, lat = args

    super(
      Sequel.lit("ST_GeomFromText('POINT(#{long} #{lat})', 4326)")
    )
  end

end
