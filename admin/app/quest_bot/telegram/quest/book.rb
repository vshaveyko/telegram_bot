# :nodoc:
class Telegram::Quest::Book < Telegram::Base

  MESSAGE = /#{Telegram::Commands::BOOK_INDEX}/

  def call
    sender.edit_message(
      text: quest.schedule_text,
      inline_buttons: [
        Telegram::Commands.comment_button(quest),
        [
          Telegram::Commands.quest_show_more_through_edit(quest),
          Telegram::Commands.schedule_button(quest)
        ].compact,
      ]
    )

    # sender.send_message(
    #   text:           'Выберите время',
    #   inline_buttons: schedule_buttons
    # )
  end

private

  def schedule_buttons
    schedule_loader.load_not_busy.each_slice(4).map do |schedule_slice|

      schedule_slice.map do |schedule_item|
        params = query_params(schedule_item)

        Telegram::Commands.schedule_request_button(schedule_item, params)
      end

    end
  end

  def schedule_loader
    Api::ScheduleLoader.new(DateTime.current.to_date, quest.quest_games_quest_id)
  end


  def query_params(schedule_item)
    "?" + { quest_id: quest.id,
            time:     schedule_item.time,
            price:    schedule_item.price,
            is_busy:  schedule_item.busy? }.to_query
  end
  #
end
