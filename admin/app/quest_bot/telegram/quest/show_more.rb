# :nodoc:
class Telegram::Quest::ShowMore < Telegram::Base

  MESSAGE = /#{Telegram::Commands::QUEST_GET_MORE}/

  def call
    quest_presenter = QuestPresenter.new(quest)

    if quest.image_url
      sender.send_photo(
        photo:   quest.image_url,
        caption: quest_presenter.name_ppl
      )
    end

    # if quest.video_url.present?
    #   sender.send_video(
    #     video: quest.video_url
    #   )
    # end

    sender.send_message(
      text:           quest_presenter.expanded_info,
      inline_buttons: [
        Telegram::Commands.quest_contacts_button(quest),
        Telegram::Commands.comment_button(quest),
        Telegram::Commands.schedule_button(quest)
      ]
    )
  end

end
