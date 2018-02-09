# :nodoc:
module Telegram::Message::Arenda::Location

  include Telegram::Message::ClosestLocation

private

  def next_page_finder
    @next_page_finder ||= Lunua::UserNextPage.new(user)
  end

  def next_page
    @next_page ||= next_page_finder.call
  end

  def buttons
    [
      get_more_button,
      # get_location_button,
      # show_on_map_button
    ]
  end

  def get_more_button
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text: "Следующая квартира (#{next_page_finder.current_index} / #{next_page_finder.found_count})",
      callback_data: '/arenda_get_more'
    )
  end

  # def show_on_map_button
  #   Telegram::Bot::Types::InlineKeyboardButton.new(
  #     text: "Следующая квартира (#{next_page_finder.current_index} / #{next_page_finder.found_count})",
  #     callback_data: '/arenda_get_more'
  #   )
  # end
  #
  # def get_location_button
  #   Telegram::Bot::Types::InlineKeyboardButton.new(
  #     text: "Следующая квартира (#{next_page_finder.current_index} / #{next_page_finder.found_count})",
  #     callback_data: '/arenda_get_more'
  #   )
  # end
  #
end
