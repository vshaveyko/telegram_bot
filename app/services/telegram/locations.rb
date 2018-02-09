# frozen_string_literal: true

# :nocov:
# class Telegram::Locations
#
#   # request : Rack::Request
#   def initialize(request)
#     @request = request
#   end
#
#   def response_body
#     # complex db logic to get points
#     Repository::ClosestFeatures.new(lat: params['lat'], long: params['long'])
#                                .bounding_circle
#   end
#
#   def params
#     @params ||= Rack::Utils.parse_nested_query(
#       @request.query_string
#     )
#   end
#
# end
