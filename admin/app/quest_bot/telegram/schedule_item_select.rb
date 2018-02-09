# :nodoc:
class Telegram::ScheduleItemSelect < Telegram::Base

  MESSAGE = /#{Telegram::Commands::SELECT_SCHEDULE_ITEM}/

  KB = [
    Telegram::Bot::Types::InlineKeyboardButton.new(text: "Купить (скоро) \u{1F408}", callback_data: "Купить (скоро) \u{1F408}"),
    Telegram::Bot::Types::InlineKeyboardButton.new(text: "Забронировать (скоро) \u{1F415}",
                                                   callback_data: "Забронировать (скоро) \u{1F415}"),
  ]

  def call
    sender.send_message(
      text:           message_info.schedule_item.present_selected,
      inline_buttons: KB
    )
  end

end
