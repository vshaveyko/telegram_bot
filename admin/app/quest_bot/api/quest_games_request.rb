# :nodoc:
class Api::QuestGamesRequest < Api::Request

  base_uri 'https://questgames.com.ua'
  headers('Host' => 'questgames.com.ua',
          'Referer' => 'https://questgames.com.ua/raspisanie-kvestov-kiev')

  # include HttpPartyProxied

  def initialize(quest_games_quest_id)
    @quest_games_quest_id = quest_games_quest_id
  end

private

  def quest_id
    @quest_id ||= @quest_games_quest_id.match(/(\d+)$/).captures.first
  end

end
