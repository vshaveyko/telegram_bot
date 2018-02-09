class Quest < ApplicationRecord

  belongs_to :quest_location, counter_cache: :quests_count

  has_many :comments, class_name: 'QuestComment', dependent: :destroy

  accepts_nested_attributes_for :comments, allow_destroy: true

  enum info_type: [:simple, :quest_games, :own_api]

  def parse_comments!
    return if quest_games_quest_id.blank?
    return if comments_count > 0

    Api::CommentLoader.new(quest_games_quest_id).all_comments.each do |comment_text|
      comments.find_or_create_by(body: comment_text)
    end
  end

end
