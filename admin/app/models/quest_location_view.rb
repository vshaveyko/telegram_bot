class QuestLocationView < ApplicationRecord

  belongs_to :quest_user
  belongs_to :quest_location

  scope :is_valid, -> { where(is_valid: true) }

end
