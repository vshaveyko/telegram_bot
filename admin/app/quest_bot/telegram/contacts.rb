# :nodoc:
class Telegram::Contacts < Telegram::Base

  MESSAGE = /#{Telegram::Commands::CONTACTS}/

  def call
    sender.edit_message(
      text: quest_location_presenter.contacts_info
    )
  end

private

  def quest_location_presenter
    @quest_location_presenter ||= QuestLocationPresenter.presenter_for(quest_location)
  end

end
