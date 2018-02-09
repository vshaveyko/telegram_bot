class Telegram::Bot::Types::CallbackQuery
  def location
    nil
  end

  def text
    data
  end

  def chat
    message.chat
  end
end

class Telegram::Bot::Types::InlineQuery

  def location
    nil
  end

  def text
    query
  end

  def chat
    nil
  end

end

Dir[__dir__ + '/telegram/**/*.rb'].each {|file| require file }

# :nodoc:
class QuestBot

  class << self

    def init
      LOGGER.debug("Using token #{token}")

      Telegram::Bot::Client.run(token) do |bot|
        running = true

        Signal.trap('TERM') { running = false }

        TelegramSender.bot = bot

        while running do
          begin
            bot.fetch_updates do |message|
              LOGGER.info("Incoming message: text=#{message.text}")

              message_info = MessageInfo.new(message)
              sender       = TelegramSender.new(message)

              if message.location
                t_message = Telegram::ClosestQuest.new(sender, message_info)
              else
                klass = (::Telegram::Base.messages.detect do |m|
                  if defined?(m::MESSAGE)
                    m::MESSAGE === message.text
                  end
                end || Telegram::Default)

                t_message = klass.new(sender, message_info)
              end

              begin
                GoogleAnalytics.track(t_message, message_info, message)

                t_message.call
              rescue Exception => err
                LOGGER.debug("ERROR HApened: #{err.message}, #{err.backtrace[0]}")
              end # begin
            end # fetch_updates
          rescue Exception => err
            if err.is_a?(Interrupt)
              fail err
            end

            LOGGER.debug("ERROR HApened: #{err.message}, #{err.backtrace[0]}, #{err.class}")
          end # begin
        end # while
      end # client.run
    end # def

  private

    def token
      @token ||= ENV.fetch('TELEGRAM_QUEST_BOT_TOKEN') { '476152967:AAFHxrMl7KCGO7VL76K-IgYRPN94ooxkrJ0' }
    end

  end # class << self
end # class
