# frozen_string_literal: true

require_relative 'request'
class Lunua::Crawler < Lunua::Request

  self.sub_uri = '/geojson/search/allRealtiesPoints?city=1&contractType=2&realtyType=1'

  attr_reader :response

  def initialize
    @response = self.class.get
  end

  # {
  #     "type": "FeatureCollection",
  #     "features": [
  #         {
  #             "type": "Feature",
  #             "geometry": {
  #                 "type": "Point",
  #                 "coordinates": [
  #                     30.5455,
  #                     50.4114
  #                 ]
  #             },
  #             "properties": {
  #                 "geohashPrefix": "u8vwz14ed"
  #             }
  #         },
  #     ]
  # }
  def call
    progressbar = ProgressBar.create(total: parsed_response.length,
                                     name: self.class.name)

    parsed_response.each do |feature|
      geometry  = feature['geometry']
      props     = feature['properties']
      long, lat = geometry['coordinates']

      Lunua::Feature.create(
        type:           feature['type'],
        geometry_type:  geometry['type'],
        geometry_lat:   lat,
        geometry_long:  long,
        position:       [long, lat],
        geohash_prefix: props['geohashPrefix'],
        created_at:     Time.now,
        updated_at:     Time.now
      )

      progressbar.increment
    end
  end

  private

  def parsed_response
    @parsed_response ||= Lunua::ResponseParser.new(@response).parse
  end

end
