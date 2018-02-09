# :nodoc:
class QuestLocation::LightPresenter < QuestLocationPresenter

  def quest_presenter(quest)
    Quest::LightPresenter.new(quest)
  end

  def info_message
    TextTranslation.get_translation(
      'quest_location.presenter.info_message_light'
    )
  end

end
