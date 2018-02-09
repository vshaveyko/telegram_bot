class Telegram::Quest::MakeFavourite < Telegram::Base

  MESSAGE = /#{Telegram::Commands::MAKE_FAVOURITE}/

  # def call
  #   # Mark as favourite by current user
  #   user.favourite_quest!(quest)
  # end

private

  def quest
    quest_id = @message.text.match(/\?id=(\d+)/).captures.first.to_i

    Quest.find(quest_id)
  end

end
