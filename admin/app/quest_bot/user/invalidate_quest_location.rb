class User::InvalidateQuestLocation

  def initialize(user)
    @user = user
  end

  def call(quest_location)
    @user.quest_location_views.create!(
      quest_location: quest_location
    )
  end

end
