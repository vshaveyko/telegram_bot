# :nodoc:
class Telegram::Location::NextClosest < Telegram::Base

  MESSAGE = /(другие|другой|еще) ?(квесты?)?$/i

  def call(buttons: nil)
    if user.location_too_old? || closest_quest_location.nil?
      return delegate_message_to(Telegram::Location::RequestUpdate)
    end

    invalidate_location

    send_venue_message(buttons)

    send_quest_list_messages

    send_info_message
  end

private

  def invalidate_location
    User::InvalidateQuestLocation.new(user).call(closest_quest_location)
  end

  def send_venue_message(buttons)
    message_data = {
      latitude:  closest_quest_location.lat,
      longitude: closest_quest_location.long,
      title:     closest_quest_location.name,
      address:   closest_quest_location.address,
    }

    sender.send_venue(data: message_data, buttons: buttons)
  end

  def send_quest_list_messages
    closest_quest_location.quests.each do |quest|
      quest_presenter = location_presenter.quest_presenter(quest)

      if quest.image_url
        sender.send_photo(
          photo:   quest.image_url,
          caption: quest_presenter.name_ppl
        )
      end

      sender.send_message(
        text:           quest_presenter.quest_schedule,
        inline_buttons: [
          Telegram::Commands.book_button(quest),
          [
            Telegram::Commands.comment_button(quest),
            Telegram::Commands.quest_show_more_through_edit(quest),
          ].compact,
        ]
      )
    end
  end

  def send_info_message
    sender.send_message(
      text: location_presenter.info_message,
      inline_buttons: [
        Telegram::Commands.quest_location_contacts_button(closest_quest_location)
      ]
    )
  end

  def location_presenter
    @location_presenter ||= QuestLocationPresenter.presenter_for(closest_quest_location)
  end

  def closest_quest_location
    return @closest_quest_location if defined?(@closest_quest_location)

    @closest_quest_location = quest_location || QuestLocation.unviewed_by_user_id(user.id)
      .closest_to_point(user.current_position)
  end

end
