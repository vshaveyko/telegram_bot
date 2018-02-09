# frozen_string_literal: true

Sequel.migration do
  transaction
  change do
    run(' CREATE EXTENSION postgis; ')

    create_table(:features) do
      primary_key(:id, type: :Bignum)

      String(:type)
      String(:geometry_type)

      Float(:geometry_lat)
      Float(:geometry_long)
      column(:position, 'geometry(Point,4326)')

      String(:geohash_prefix)
    end
  end
end
