# frozen_string_literal: true
require('logger')

LOGGER = Logger.new($stderr)

require_relative('config/boot')

Telegram::LocationsBot.start

#
# class Route
#
#   def initialize(_end_point_class)
#     @end_point_class
#   end
#
#   def call(env)
#     request  = Rack::Request.new(env)
#     response = Rack::Response.new
#
#     body = @end_point_class.new(request).response_body
#
#     response.body = body
#     response.finish
#   rescue
#     response.status = 500
#     response.finish
#   end
#
# end


# map('/locations') do
#   run(Route.new(Telegram::Locations))
# end
