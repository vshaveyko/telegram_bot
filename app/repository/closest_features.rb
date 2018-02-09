# frozen_string_literal: true
require_relative '../models/lunua/feature.rb'
# :nodoc:
class ClosestFeatures

  # DISTANCE = 20

  # def initialize(lat:, long:)
  #   @lat  = lat
  #   @long = long
  # end

  # def bounding_circle
  #   <<~SQL
  #     SELECT *
  #     FROM your_table
  #     WHERE ST_Distance_Sphere(the_geom, ST_MakePoint(your_lon,your_lat)) <= radius_mi * 1609.34
  #   SQL
  # end

  def closest_for_user(user)
    user.refresh

    order_by = Sequel.lit(
      "ST_Distance(position, '#{user.current_position}') ASC"
    )

    # left inner join user_features on user_id == user.id
    Lunua::Feature
      .graph(Lunua::UsersFeature.table_name, { feature_id: :id, user_id: user.id }.to_a)
      .where(user_id: nil)
      .order(order_by).first
  end

end
