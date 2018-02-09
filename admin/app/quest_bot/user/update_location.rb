# :nodoc:
class User::UpdateLocation

  def initialize(user, message)
    @user    = user
    @message = message
  end

  def call
    save_user_location

    invalidate_quest_cache
  end

private

  def save_user_location
    @user.update!(
      current_position:           [long, lat],
      latest_location_updated_at: DateTime.current
    )
  end

  def invalidate_quest_cache
    User::InvalidateQuestCache.new(@user).call
  end

  def long
    @message.location.longitude
  end

  def lat
    @message.location.latitude
  end

end
