class Telegram::Quest::MakeVisited < Telegram::Base

  MESSAGE = /#{Telegram::Commands::MAKE_VISITED}/

  # def call
  #   # Mark as visited by current user
  #   user.visited_quest!(quest)
  # end

private

  def quest
    quest_id = @message.text.match(/\?id=(\d+)/).captures.first.to_i

    Quest.find(quest_id)
  end

end
