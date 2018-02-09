class Telegram::Message::Start < Telegram::Message

  MESSAGE = '/start'

  kb = [
    # Telegram::Bot::Types::KeyboardButton.new(text: 'Аренда'),
    Telegram::Bot::Types::KeyboardButton.new(text: "Аренда квартиры рядом \u{1F415}", request_location: true),
    Telegram::Bot::Types::KeyboardButton.new(text: "Продажа (скоро) \u{1F408}"),
    Telegram::Bot::Types::KeyboardButton.new(text: "Новостройки рядом (скоро) \u{1F3D7} \u{FE0F} ")
  ]

  LOCATION_BUTTON = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb,
                                                                  resize_keyboard: true,
                                                                  one_time_keyboard: true)

  def call
    send_message(
      text: 'Привет. Я бот, который поможет найти вам квартиру для аренды или покупки 🤗 ',
      reply_markup: LOCATION_BUTTON
    )
  end

end
