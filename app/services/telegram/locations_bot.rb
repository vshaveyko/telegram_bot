# frozen_string_literal: true
# :nodoc:

class Telegram::Bot::Types::CallbackQuery
  def location
    nil
  end
end

class Telegram::LocationsBot

  def self.start
    token = ENV['TELEGRAM_TOKEN']

    LOGGER.debug("Using token #{token}")

    Telegram::Bot::Client.run(token) do |bot|
      running = true

      Signal.trap('TERM') { running = false }

      while running do
        begin
          bot.fetch_updates do |message|
            if message.location
              LOGGER.info("Incoming message: text=#{message.text}")

              next Telegram::Message::Arenda::GetClosest.new(bot, message).call
            end

            if message.is_a?(Telegram::Bot::Types::CallbackQuery)
              message_text = message.data
              message      = message.message
            else
              message_text = message.text
            end

            LOGGER.info("Incoming message: text=#{message_text}")

            (Telegram::Message.messages.detect do |m|
              m::MESSAGE === message_text
            end || Telegram::Message::Default).new(bot, message).call
          end
        rescue Exception => err
          LOGGER.debug("ERROR HApened: #{err.message}, #{err.backtrace[0]}")
        end
      end
    end
  end

end
