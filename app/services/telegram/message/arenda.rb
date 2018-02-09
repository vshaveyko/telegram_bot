# :nodoc:
class Telegram::Message::Arenda < Telegram::Message

  MESSAGE = 'Аренда'

  kb = [
    Telegram::Bot::Types::KeyboardButton.new(text: 'Аренда рядом', request_location: true),
    Telegram::Bot::Types::KeyboardButton.new(text: 'Аренда по улице ... (скоро)')
  ]

  MENU = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb,
                                                       resize_keyboard: true)

  def call
    send_message(
      text: 'Как будем искать?',
      reply_markup: MENU
    )
  end

end
