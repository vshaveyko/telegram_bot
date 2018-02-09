# :nodoc:
class Telegram::Quest::ShowMoreEdit < Telegram::Base

  MESSAGE = /#{Telegram::Commands::QUEST_GET_MORE_edit}/

  def call
    quest_presenter = QuestPresenter.new(quest)

    sender.edit_message(
      text:           quest_presenter.expanded_info,
      inline_buttons: [
        Telegram::Commands.book_button(quest),
        [
          Telegram::Commands.comment_button(quest),
          Telegram::Commands.schedule_button(quest)
        ].compact
      ]
    )
  end

end
