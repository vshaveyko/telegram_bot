#
# TODO: Temp inheritance, change to main class when get this done
#
class Quest::VipPresenter < Quest::StandardPresenter

  def inline_buttons
    first_line = []

    first_line << Telegram::Commands.book_button(@quest) if @quest.schedule_text.present?
    first_line << Telegram::Commands.comment_button(@quest) if @quest.comments.size > 0


    buttons = [
      first_line,
      Telegram::Commands.quest_show_more_button(@quest)
    ]
  end

end
