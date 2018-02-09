# frozen_string_literal: true

require('spec_helper')

RSpec.describe(Lunua::Crawler) do
  url = 'https://www.lun.ua/geojson/search/allRealtiesPoints?city=1&contractType=2&realtyType=1'
  mocked_body = {
    "type": 'FeatureCollection',
    "features": [
      {
        "type": 'Feature',
        "geometry": {
          "type": 'Point',
          "coordinates": [
            30.5455,
            50.4114
          ]
        },
        "properties": {
          "geohashPrefix": 'u8vwz14ed'
        }
      }
    ]
  }.to_json

  before(:all) do
    stub_request(:get, url).to_return(status: 200, body: mocked_body)
  end

  it('persists records to db') do
    subject.call

    expect(DB[:features].first).to(include(
                                     type:           'Feature',
                                     geometry_type:  'Point',
                                     geometry_long:  30.5455,
                                     geometry_lat:   50.4114,
                                     geohash_prefix: 'u8vwz14ed'
    ))
  end
end
