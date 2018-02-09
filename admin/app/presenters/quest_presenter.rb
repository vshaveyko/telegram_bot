# :nodoc:
class QuestPresenter

  def initialize(quest)
    @quest = quest
  end

  def favourites_message
    @quest.name
  end

  def closest_message
    <<~TEXT
    #{@quest.name}, #{@quest.address}
    #{ppl_range}, #{cost_range}
    #{@quest.estimated_time}
    TEXT
  end

  def expanded_info
    TextTranslation.get_translation(
      'quest.presenter.description{quest_name}{quest_ppl_range}{quest_description_text}{quest_location_info}{video_url}',
      { quest_name: @quest.name, quest_ppl_range: ppl_range, quest_description_text: description, quest_location_info: quest_location_descritpion, video_url: @quest.video_url }
    )
  end

  def name_ppl
    TextTranslation.get_translation(
      'quest.presenter.img_caption{quest_name}{quest_ppl_range}{quest_description_text}{quest_location_info}{video_url}',
      { quest_name: @quest.name, quest_ppl_range: ppl_range, quest_description_text: description, quest_location_info: quest_location_descritpion, video_url: @quest.video_url }
    )
  end

  #
  # *При чем тут панда*
  # 10:15, 13:15, 16:15, 19:15 — 600 ₴,
  # 22:15 — 800 ₴
  # *12 Стульев (NEW)*
  # _все занято_
  #
  def name_with_schedule
    <<~QUEST_INFO
      *#{@quest.name}*
      #{quest_schedule}
    QUEST_INFO
  end

  # redefined
  def inline_buttons
    []
  end

  def quest_schedule
    if @quest.simple?
      cost_range
    elsif @quest.quest_games?
      schedule = schedule_loader.load_not_busy

      SchedulePresenter.new(schedule).quest_schedule
    elsif @quest.own_api?
      "Not implemented"
    end
  end

private

  def ppl_range
    TextTranslation.get_translation(
      'quest.presenter.ppl_range{ppl_min}{ppl_max}',
      { ppl_min: @quest.ppl_min, ppl_max: @quest.ppl_max }
    )
  end

  # От 200 до 600 грн за игру
  def cost_range
    TextTranslation.get_translation(
      'quest.presenter.cost_range{cost_min}{cost_max}',
      { cost_min: @quest.cost_min, cost_max: @quest.cost_max }
    )
  end

  def schedule_loader
    @schedule_loader ||= Api::ScheduleLoader.new(DateTime.current.to_date, @quest.quest_games_quest_id)
  end

  def quest_location_descritpion
    QuestLocationPresenter.new(@quest.quest_location).name_and_address
  end

  def description
    if @quest.description.present?
      ActionController::Base.helpers
        .truncate(
          @quest.description,
          length: 400,
          omission: '...'
        )
    end
  end

  # вт,2 Окт.
  def parsed_current_date
    I18n.localize(Date.current, format: "%a, %e %b")
  end

end
