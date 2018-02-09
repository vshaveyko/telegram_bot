# :nodoc:
class Telegram::Quest::Schedule < Telegram::Base

  MESSAGE = /#{Telegram::Commands::QUEST_SCHEDULE}/

  def call
    quest_presenter = QuestPresenter.new(quest)

    sender.edit_message(
      text: quest_presenter.quest_schedule,
      inline_buttons: [
        Telegram::Commands.book_button(quest),
        [
          Telegram::Commands.comment_button(quest),
          Telegram::Commands.quest_show_more_through_edit(quest),
        ].compact
      ]
    )
  end

end
