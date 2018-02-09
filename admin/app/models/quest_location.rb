class QuestLocation < ApplicationRecord

  has_many :quests, dependent: :destroy

  has_many :views, class_name: 'QuestLocationView',
                   dependent: :destroy

  has_many :quest_location_views, -> { is_valid }, class_name: 'QuestLocationView',
                                                   dependent: :destroy

  accepts_nested_attributes_for :quests

  before_save do
    next unless long_changed? || lat_changed?

    self.position = "POINT(#{long} #{lat})"
  end

  def self.closest_to_point(point)
    order("ST_Distance(position, '#{point}') ASC").first
  end

  scope :viewed_by_user_id, -> (user_id) {
    joins(:quest_location_views)
      .where(quest_location_views: { quest_user_id: user_id })
  }

  scope :unviewed_by_user_id, -> (user_id) {
    where.not(
      id: viewed_by_user_id(user_id)
    )
  }

  enum feature_type: [:light, :standard, :vip]

  def to_s
    address
  end

end
