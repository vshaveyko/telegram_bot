# :nodoc:
class QuestLocationPresenter

  def self.presenter_for(quest_location)
    if quest_location.light?
      QuestLocation::LightPresenter.new(quest_location)
    elsif quest_location.standard?
      QuestLocation::StandardPresenter.new(quest_location)
    elsif quest_location.vip?
      QuestLocation::VipPresenter.new(quest_location)
    end
  end

  def initialize(quest_location)
    @quest_location = quest_location
  end

  #
  # *Квест-комнаты 60*
  # Оболонская, 21
  #
  # Свободное время на вт,2 Окт.
  #
  # *Музей невозможных фигур*
  # 10:15, 13:15, 19:15 — 600 ₴,
  # 22:15 — 800 ₴
  # *При чем тут панда*
  # 10:15, 13:15, 16:15, 19:15 — 600 ₴,
  # 22:15 — 800 ₴
  # *12 Стульев (NEW)*
  # _все занято_
  #
  def closest_message
    head + @quest_location.quests.map { |q| quest_info(q) }.join("\n")
  end

  def name_and_address
    <<~TEXT
     *#{@quest_location.name}*
     #{@quest_location.address}
    TEXT
  end

  #
  # *Название локации*
  # +393192312312323
  #
  def contacts_info
    TextTranslation.get_translation(
      'quest_location.presenter.contacts_info{quest_location_name}{phone_number}',
      { quest_location_name: @quest_location.name, phone_number: phone_number }
    )
  end

  # redefined
  def info_message
    ''
  end

private
  #
  def head
    <<~HEAD
    Свободное время на #{parsed_current_date}

    HEAD
  end

  # вт,2 Окт.
  def parsed_current_date
    I18n.localize(Date.current, format: "%a, %e %b")
  end

  def quest_info(quest)
    quest_presenter(quest).name_with_schedule
  end

  def phone_number
    if @quest_location.phone_number.present?
      @quest_location.phone_number
    else
      'Номер не укзана'
    end
  end

end
