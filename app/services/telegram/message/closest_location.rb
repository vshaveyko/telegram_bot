# :nodoc:
module Telegram::Message::ClosestLocation

  def call
    location_message = Telegram::LocationMessage.new(next_page)

    send_photo(
      location_message.photo.merge(
        reply_markup: Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [
          Telegram::Bot::Types::InlineKeyboardButton.new(location_message.show_button)
        ])
      )
      #
    )

    # send_message(
    #   location_message.message_text
    #   # text: feature.text,
    # )

    send_venue(
      location_message.venue.merge(
        reply_markup: Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
      )
    )
  end

end
