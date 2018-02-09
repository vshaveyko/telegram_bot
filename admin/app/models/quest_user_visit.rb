class QuestUserVisit < ApplicationRecord
  belongs_to :quest_user
  belongs_to :quest
end
