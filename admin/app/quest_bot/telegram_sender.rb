# :nodoc:
class TelegramSender

  class << self
    attr_accessor :bot
  end

  def bot_api
    self.class.bot.api
  end

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def send_message(text:, buttons: [], inline_buttons: [])
    LOGGER.info("Sending message: text=#{text}")

    unless @message.chat
      return
    end

    bot_api.send_message({
      chat_id: @message.chat.id,
      text:         text,
      parse_mode:   'Markdown',
    }.merge(
      reply_markup(
        buttons:        buttons,
        inline_buttons: inline_buttons)
    ))
  end

  def edit_message(text:, buttons: [], inline_buttons: [])
    LOGGER.info("Editing message: text=#{text}")

    bot_api.edit_message_text(
      chat_id:      @message.chat.id,
      message_id:   @message.message.message_id,
      text:         text,
      parse_mode:   'Markdown',
      reply_markup: Telegram::Bot::Types::InlineKeyboardMarkup.new( # clear buttons by default
        inline_keyboard: inline_buttons
      )
    )
  end

  # {
  #   photo:   @next_page.photo_url,
  #   caption: @next_page.text
  # }
  def send_photo(options)
    options[:chat_id] = @message.chat.id

    bot_api.send_photo(options)
    # reply_to_message_id: @message.id,
  end

  def send_video(options)
    options[:chat_id] = @message.chat.id

    bot_api.send_video(options)
  end

  def send_venue(data:, buttons: [], inline_buttons: [])
    data[:chat_id] = @message.chat.id

    bot_api.send_venue(
      data.merge(
        reply_markup(
          buttons:        buttons,
          inline_buttons: inline_buttons
        )
      )
    )
  end

private

  def reply_markup(buttons: [], inline_buttons: [])
    buttons&.reject!(&:blank?)
    inline_buttons&.reject!(&:blank?)

    if buttons.present?
      {
        reply_markup: Telegram::Bot::Types::ReplyKeyboardMarkup.new(
          keyboard:        buttons,
          resize_keyboard: true
        )
      }
    elsif inline_buttons.present?
      {
        reply_markup: Telegram::Bot::Types::InlineKeyboardMarkup.new(
          inline_keyboard: inline_buttons
        )
      }
    else
      {}
    end

  end

end
