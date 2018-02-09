require_relative 'config/environment'

require_relative './app/quest_bot/quest_bot'

#
# Rails.logger = LOGGER

if Rails.env.production?
  LOGGER = Rails.logger
else
  LOGGER = Logger.new($stdout)
end

QuestBot.init
