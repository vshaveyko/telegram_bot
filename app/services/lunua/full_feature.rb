# frozen_string_literal: true

require_relative 'request'
# :nodoc:
class Lunua::FullFeature < Lunua::Request

  class << self

    def pages_for_feature(feature)
      new(feature).pages
    end

  end

  self.sub_uri = '/ajax/search/getRealtiesListingData'

  def initialize(feature)
    @feature = feature
  end

  def pages
    response
  end

  private

  def response
    @response ||= Oj.load(self.class.get(query: query_params).body)
  end

  def query_params
    {
      city: 1,
      contractType: 2,
      page: :all,
      realtyType: 1,
      geohashPrefix: @feature.geohash_prefix
    }
  end

end
