# :nodoc:
class QuestLocation::StandardPresenter < QuestLocationPresenter

  def quest_presenter(quest)
    Quest::StandardPresenter.new(quest)
  end

  def info_message
    TextTranslation.get_translation(
      'quest_location.presenter.info_message_standard'
    )
  end

end
