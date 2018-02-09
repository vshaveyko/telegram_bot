# :nodoc:
class Telegram::ClosestQuest < Telegram::Base

  MESSAGE = 'ClosestQuest'

  def call
    sender.send_message(
      text:    TextTranslation.get_translation('message.closest_quest.looking_near'),
      buttons: [ [Telegram::Commands.show_more_button, Telegram::Commands.reset_sort_button ]]
    )

    delegate_message_to(Telegram::Location::NextClosest)
  end

end
