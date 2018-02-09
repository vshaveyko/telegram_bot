# :nodoc:
class Telegram::Quest::Comment < Telegram::Base

  MESSAGE = /#{Telegram::Commands::COMMENT_INDEX}/

  def call
    sender.edit_message(
      text: quest.comments.randomize.first.body,
      inline_buttons: [
        Telegram::Commands.comment_button(quest, button_title: 'buttons.more_comment'),
        Telegram::Commands.book_button(quest),
        [
          Telegram::Commands.quest_show_more_through_edit(quest),
          Telegram::Commands.schedule_button(quest)
        ].compact,
      ]
    )
  end

end
