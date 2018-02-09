# :nodoc:
class MessageInfo

  def initialize(message)
    @message           = message
    @message_user_info = MessageUserInfo.new(message)
    @message_user_info.update_user!
  end

  def user
    @message_user_info.user
  end

  def quest
    return @quest if defined?(@quest)

    matches = message_text.match(/quest_id=(\d+)/)

    unless matches
      return @quest = nil
    end

    quest_id = message_text.match(/quest_id=(\d+)/).captures.first.to_i

    @quest = Quest.find(quest_id)
  end

  def quest_location
    return @quest_location if defined?(@quest_location)

    matches = message_text.match(/quest_location_id=(\d+)/)

    unless matches
      return @quest_location = nil
    end

    quest_location_id = matches.captures.first.to_i

    @quest_location = QuestLocation.find(quest_location_id)
  end

  def schedule_item
    text = CGI.unescape(message_text)

    time     = text.match(/time=([\d:]+)&?/).captures.first
    price    = text.match(/price=(\d+)&?/).captures.first
    is_busy  = text.match(/is_busy=(true|false)&?/).captures.first

    ScheduleItemPresenter.new(
      time:     time,
      price:    price,
      is_busy:  is_busy
    )
  end

private

  def message_text
    @message.text || ''
  end

end
