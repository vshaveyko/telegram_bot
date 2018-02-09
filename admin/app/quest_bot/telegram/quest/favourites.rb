class Telegram::Quest::Favourites < Telegram::Base

  MESSAGE = /Хочу посетить/

  DEFAULT_TEXT = 'У вас еще нет сохраненных квестов'

  # def call
  #   if user.favourite_quests.exists?
  #     message_text = user.favourite_quests.map { |q|
  #       QuestPresenter.new(q).favourites_message + "\n"
  #     }
  #   else
  #     message_text = DEFAULT_TEXT
  #   end
  #
  #   # List marked favourites
  #   send_message(
  #     text: message_text
  #   )
  # end

end
