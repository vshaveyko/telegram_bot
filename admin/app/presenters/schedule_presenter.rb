# :nodoc:
class SchedulePresenter

  def initialize(schedule)
    @schedule = schedule
  end

  def quest_schedule
    if @schedule.empty?
      TextTranslation.get_translation('quest.presenter.all_busy{current_date}', { current_date: parsed_current_date })#{ }"_все занято_"
    else
      @schedule.group_by(&:price).map do |price, items|
        times = items.map(&:time) # 10:15, 13:15, 16:15, 19:15
        times.join(', ') + " — #{price} ₴"
      end.join(",\n")
    end

  end

private

  # вт,2 Окт.
  def parsed_current_date
    I18n.localize(Date.current, format: "%a, %e %b")
  end

end
