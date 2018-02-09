# :nodoc:
class QuestLocation::VipPresenter < QuestLocationPresenter

  def quest_presenter(quest)
    Quest::VipPresenter.new(quest)
  end

  def info_message
    TextTranslation.get_translation(
      'quest_location.presenter.info_message_vip'
    )
  end

end
