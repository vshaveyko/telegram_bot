# :nodoc:
module Telegram::Commands

  MAKE_FAVOURITE       = '/make_favourite'
  MAKE_VISITED         = '/make_visited'

  SELECT_SCHEDULE_ITEM = '/schedule_item'

  NEXT_CLOSEST_QUEST   = '/next_closest'

  CONTACTS             = '/contacts'
  QUEST_CONTACTS       = '/quest_contacts'

  QUEST_GET_MORE       = '/quest_get_more'
  QUEST_GET_MORE_edit  = '/edit_quest_get_more'

  BOOK_INDEX           = '/book_index'

  COMMENT_INDEX        = '/comment_index'

  QUEST_SCHEDULE       = '/quest_schedule'

  module_function

  def book_button(quest, button_title: 'buttons.book!')
    if quest.quest_url.present?
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text: TextTranslation.get_translation(button_title),
        url:  quest.quest_url
      )
    elsif quest.schedule_text.present?
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text:          TextTranslation.get_translation(button_title),
        callback_data: BOOK_INDEX + quest_callback_data(quest)
      )
    end
  end

  def comment_button(quest, button_title: 'button.comments')
    if quest.comments.size > 0
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text:          TextTranslation.get_translation(button_title),
        callback_data: COMMENT_INDEX + quest_callback_data(quest)
      )
    end
  end

  def schedule_button(quest)
    button_name = quest.quest_games? ? 'buttons.schedule' : 'buttons.cost'

    Telegram::Bot::Types::InlineKeyboardButton.new(
      text:          TextTranslation.get_translation(button_name),
      callback_data: QUEST_SCHEDULE + quest_callback_data(quest)
    )
  end

  def dummy_button(text)
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text:          text,
      callback_data: '(скоро)'
    )
  end

  def schedule_request_button(schedule_item, params)
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text:          schedule_item.time,
      callback_data: '(скоро)' # SELECT_SCHEDULE_ITEM + params
    )
  end

  SHOW_MORE_BUTTON = TextTranslation.get_translation('buttons.show_more')

  def show_more_button
    Telegram::Bot::Types::KeyboardButton.new(text: SHOW_MORE_BUTTON)
  end

  RESET_BUTTON = TextTranslation.get_translation('buttons.reset')

  def reset_sort_button
    Telegram::Bot::Types::KeyboardButton.new(text: RESET_BUTTON)
  end

  def quest_show_more_button(quest)
    callback_data = Telegram::Commands::QUEST_GET_MORE + quest_callback_data(quest)

    Telegram::Bot::Types::InlineKeyboardButton.new(
      text:          'Больше о квесте',
      callback_data: callback_data
    )
  end

  def quest_show_more_through_edit(quest)
    callback_data = Telegram::Commands::QUEST_GET_MORE_edit + quest_callback_data(quest)

    if quest.description.present?
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text:          TextTranslation.get_translation('quest_description.button.edit_name'),
        callback_data: callback_data
      )
    end
  end

  def update_location_button
    Telegram::Bot::Types::KeyboardButton.new(text: "Обновить локацию",
                                             request_location: true)
  end

  def quest_location_contacts_button(quest_location)
    callback_data = Telegram::Commands::CONTACTS + quest_location_callback_data(quest_location)

    Telegram::Bot::Types::InlineKeyboardButton.new(
      text:          'Показать телефон',
      callback_data: callback_data
    )
  end

  def quest_contacts_button(quest)
    callback_data = Telegram::Commands::QUEST_CONTACTS + quest_callback_data(quest)

    Telegram::Bot::Types::InlineKeyboardButton.new(
      text:          'Показать телефон',
      callback_data: callback_data
    )
  end

  def quest_location_callback_data(quest_location)
    "?quest_location_id=#{quest_location.id}"
  end

  def quest_callback_data(quest)
    "?quest_id=#{quest.id}"
  end

end
