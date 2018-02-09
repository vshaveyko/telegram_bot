# :nodoc:
class User::InvalidateQuestCache

  def initialize(user)
    @user = user
  end

  def call
    @user.quest_location_views.update_all(
      is_valid: false
    )
  end

end
