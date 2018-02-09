class QuestUser < ApplicationRecord

  has_many :quest_visits, class_name: 'QuestUserVisit', dependent: :destroy
  has_many :visited_quests, class_name: 'Quest',
                            through: :quest_visits,
                            source: :quest

  has_many :quest_favourites, class_name: 'QuestUserFavourite', dependent: :destroy
  has_many :favourite_quests, class_name: 'Quest',
                              through: :quest_favourites,
                              source: :quest

  has_many :quest_location_views, -> { is_valid }, class_name: 'QuestLocationView',
                                                dependent: :destroy

  has_many :user_views, -> { is_valid }, class_name: 'QuestUserView',
                                         dependent: :destroy

  def favourite_quest!(quest)
    quest_favourites.find_or_create_by!(
      quest: quest
    )
  end

  def visited_quest!(quest)
    quest_visits.find_or_create_by!(
      quest: quest
    )
  end

  def current_position=(args)
    long, lat = args

    super("POINT(#{long} #{lat})")
  end

  def location_too_old?
    latest_location_updated_at&.to_date != DateTime.current.to_date
  end

end
