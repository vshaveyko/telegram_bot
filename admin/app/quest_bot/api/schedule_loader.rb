# :nodoc:
class Api::ScheduleLoader < Api::QuestGamesRequest

  self.sub_uri = '/site/GetAjaxShedule?'

  # https://questgames.com.ua/site/GetAjaxShedule?questId=362&date=2017-10-01
  def initialize(date, quest_games_quest_id)
    @date                 = date
    @quest_games_quest_id = quest_games_quest_id
  end

  def load
    @load ||= response.map do |schedule_item|
      ScheduleItemPresenter.new(schedule_item)
    end
  end

  def load_not_busy
    @load_not_busy ||= load.select(&:not_busy?)
  end

  def request_params
    {
      query: {
        questId: quest_id,
        date: @date.to_s
      }
    }
  end

end
