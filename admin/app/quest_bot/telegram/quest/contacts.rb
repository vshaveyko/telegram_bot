# :nodoc:
class Telegram::Quest::Contacts < Telegram::Base

  MESSAGE = /#{Telegram::Commands::QUEST_CONTACTS}/

  def call
    sender.edit_message(
      text: quest_location_presenter.contacts_info,
      inline_buttons: [
        Telegram::Commands.quest_show_more_through_edit(quest),
        Telegram::Commands.comment_button(quest),
        Telegram::Commands.schedule_button(quest)
      ]
    )
  end

private

  def quest_location_presenter
    @quest_location_presenter ||= QuestLocationPresenter.presenter_for(quest.quest_location)
  end

end
