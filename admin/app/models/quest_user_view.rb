class QuestUserView < ApplicationRecord

  belongs_to :quest_user
  belongs_to :viewable, polymorphic: true

  scope :is_valid, -> { where(is_valid: true) }

end
