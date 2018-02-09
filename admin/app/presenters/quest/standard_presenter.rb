class Quest::StandardPresenter < QuestPresenter

  def inline_buttons
    [
      Telegram::Commands.quest_show_more_button(@quest)
    ]
  end

  def parsed_schedule
    schedule = schedule_loader.load_not_busy

    if schedule.empty?
      TextTranslation.get_translation('quest.presenter.all_busy{current_date}', { current_date: parsed_current_date })#{ }"_все занято_"
    else
      schedule.group_by(&:price).map do |price, items|
        times = items.map(&:time) # 10:15, 13:15, 16:15, 19:15
        times.join(', ') + " — #{price} ₴"
      end.join(",\n")
    end
  end

end
