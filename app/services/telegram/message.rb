# :nodoc:
class Telegram::Message

  class << self

    def messages
      @messages ||= ObjectSpace.each_object(::Class)
                               .select { |klass| klass < self }
    end

  end

  def initialize(bot, in_message)
    @bot        = bot
    @in_message = in_message
  end

private

  def message
    @in_message
  end

  def send_message(options)
    options[:chat_id] = @in_message.chat.id

    LOGGER.info("Sending message: text=#{options[:text]}")

    @bot.api.send_message(options)
    # reply_to_message_id: @in_message.id,
  end

  def send_photo(options)
    options[:chat_id] = @in_message.chat.id

    @bot.api.send_photo(options)
    # reply_to_message_id: @in_message.id,
  end

  def send_venue(options)
    options[:chat_id] = @in_message.chat.id

    @bot.api.send_venue(options)
  end

  def user
    user ||= begin
               user_info = @in_message.from
               User.find_or_create(telegram_user_id: user_info.id.to_s) do |new_user|
                 new_user.username   = user_info.username
                 new_user.first_name = user_info.first_name
                 new_user.last_name  = user_info.last_name
                 new_user.created_at = Time.now
                 new_user.updated_at = Time.now
               end
             end
  end


end
